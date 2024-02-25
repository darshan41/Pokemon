//
//  PageViewController.swift
//  Pokemon
//
//  Created by Darshan S on 25/02/24.
//

import UIKit
import BasicPageView

final class PageView: UIViewController {
    
    private lazy var controllers: [ImageController] = {
        var cntrls: [ImageController] = []
        for _ in 1...10 {
            cntrls.append(ImageController())
        }
        return cntrls
    }()
    
    private var shouldMove: Bool = false
    
    private let pageController = BasicPageView(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    private lazy var commandCenter: PageControlCommandCenter = { PageControlCommandCenter(offsetValue: 0, limit: UInt16(controllers.count)) }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

// MARK: PageScrollNotifiable

extension PageView: PageScrollNotifiable {
    
    func inputControllersForController(_ pageViewController: UIPageViewController) -> [UIViewController] {
        controllers
    }
    
    func isCyclicPaginationController(_ pageViewController: UIPageViewController) -> Bool {
        true
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willMoveTo viewController: UIViewController?) {
        if let controllerIndex = self.controllers.firstIndex(where: { $0 === viewController }) {
            self.commandCenter.getCurrentOffset(onCompletion: { [weak self] offset in
                guard let self,offset > 0 else { return }
                print(UInt16(UInt16(controllerIndex) + offset) % offset)
                guard UInt16(UInt16(controllerIndex) + offset) % offset == 0 else { return }
                commandCenter.startPagination()
            })
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didMoveTo viewController: UIViewController?) {
        if let controllerIndex = self.controllers.firstIndex(where: { $0 === viewController }) {
            self.commandCenter.getCurrentOffset(onCompletion: { [weak self] offset in
                guard let self,offset > 0 else { return }
                commandCenter.getName(for: UInt16(UInt16(controllerIndex) + offset)) { result in
                    if let result {
                        print(result.name)
                    }
                }
            })
        }
    }
}

// MARK: PageControlCommandCenterDelegate

extension PageView: PageControlCommandCenterDelegate {
    
    func pageControlCommandCenterDidFinishLoading() {
        delay {
            self.pageController.goToNextPage()
        }
    }
    
    func pageControlCommandCenterDidFail(withError error: Error) {
        print(error)
    }
}

// MARK: Helper func's

private extension PageView {
    
    func configureView() {
        
        pageController.autoSwipeDelegate = self
        ViewEmbedder.embed(parent: self, container: self.view, child: pageController, previous: nil)
        commandCenter.delegate = self
        commandCenter.startPagination()
    }
}
