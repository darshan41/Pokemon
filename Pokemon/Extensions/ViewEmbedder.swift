//
//  ViewEmbedder.swift
//  Pokemon
//
//  Created by Darshan S on 08/02/24.
//

import UIKit

public class ViewEmbedder {
    
    public class func embed(
        parent:UIViewController,
        container:UIView,
        child:UIViewController,
        previous:UIViewController?
    ) {
        if let previous = previous {
            removeFromParent(vc: previous)
        }
        child.willMove(toParent: parent)
        parent.addChild(child)
        container.addSubview(child.view)
        child.didMove(toParent: parent)
        let w = container.frame.size.width;
        let h = container.frame.size.height;
        child.view.frame = CGRect(x: 0, y: 0, width: w, height: h)
    }
    
    public class func embedWithCons(
        parent: UIViewController,
        container: UIView,
        child: UIViewController,
        previous: UIViewController?
    ) {
        if let previous = previous {
            removeFromParent(vc: previous)
        }
        let view = child.view!
        view.translatesAutoresizingMaskIntoConstraints = false
        child.willMove(toParent: parent)
        parent.addChild(child)
        container.addSubview(child.view)
        child.didMove(toParent: parent)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: container.topAnchor),
            view.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            view.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            view.leadingAnchor.constraint(equalTo: container.leadingAnchor)
        ])
    }
    
    public class func removeFromParent(vc:UIViewController){
        vc.willMove(toParent: nil)
        vc.view.removeFromSuperview()
        vc.removeFromParent()
    }
    
    ///Make sure ParentViewController has it's own story
    public class func storBoardembed(
        withIdentifier id: String,
        parent: UIViewController,
        container: UIView,
        completion: ((UIViewController) -> Void)? = nil) {
            guard let parentStoryboard = parent.storyboard else { fatalError("ParentViewController Doen't have StoryBoard") }
            let vc = parentStoryboard.instantiateViewController(withIdentifier: id)
            embed(
                parent: parent,
                container: container,
                child: vc,
                previous: parent.children.first
            )
            completion?(vc)
        }
    
    ///Make sure ParentViewController has it's own story and with AppStoryBoard implemmentaiton.
//    public class func storBoardembed<T: UIViewController>(
//        with appStoryBoard: AppStoryBoard,
//        parent: UIViewController,
//        container: UIView,
//        completion: ((T) -> Void)? = nil
//    ) {
//        let vc = T.instantiateFromAppStoryBoard(appStoryBoard: appStoryBoard)
//        embed(
//            parent: parent,
//            container: container,
//            child: vc,
//            previous: parent.children.first
//        )
//        completion?(vc)
//    }
}



