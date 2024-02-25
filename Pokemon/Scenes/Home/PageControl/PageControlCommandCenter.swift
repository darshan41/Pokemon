//
//  PageControlCommandCenter.swift
//  Pokemon
//
//  Created by Darshan S on 25/02/24.
//

import Foundation

protocol PageControlCommandCenterDelegate: AnyObject {
    func pageControlCommandCenterDidFinishLoading()
    func pageControlCommandCenterDidFail(withError error: Error)
}

class PageControlCommandCenter {
    
    private var url: URL
    private var offsetValue: UInt16
    private let limit: UInt16
    private let pager = Pager()
    var intervalToLoad: TimeInterval?
    
    weak var delegate: PageControlCommandCenterDelegate?
    
    private let queue: DispatchQueue = .init(label: "com.PageControlCommandCenter.queue", qos: .background)
    
    init(offsetValue: UInt16,limit: UInt16) {
        self.offsetValue = offsetValue
        self.limit = limit
        self.url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offsetValue)")!
    }
    
    func getCurrentOffset(onCompletion: @escaping ((UInt16) -> Void)) {
        queue.async {
            onCompletion(self.offsetValue)
        }
    }
    
    func getName(for offset: UInt16,onCompletion: @escaping ((Pager.PageResult?) -> Void)) {
        queue.async {
            onCompletion(self.pager.results[safe: Int(offset)])
        }
    }

    func startPagination() {
        queue.async { [weak self] in
            guard let self = self else { return }
            self.callForPager(next: pager.nextAsURL) { result in
                switch result {
                case .success(let success):
//                    if self.pager.results.count > (3 * self.maxOffsetValue) {
//                        self.pager.results.removeFirst(5)
//                    }
                    self.offsetValue+=self.limit
                    self.pager.previous = success.previous
                    self.pager.next = success.next
                    print("success.next, \(success.next)")
                    self.pager.results.append(contentsOf: success.results)
                    self.delegate?.pageControlCommandCenterDidFinishLoading()
                case .failure(let failure):
                    self.delegate?.pageControlCommandCenterDidFail(withError: failure)
                }
            }
        }
    }
}

extension PageControlCommandCenter {
    
    class Pager: Codable {
        fileprivate var next: String?
        fileprivate var previous: String?
        var results: [PageResult] = []
        
        init() { }
        
        struct PageResult: Codable {
            let name: String
            let url: String
        }
        
        var nextAsURL: URL? {
            return URL(string: next ?? "https://pokeapi.co/api/v2/pokemon?limit=5&offset=0")
        }
    }
}

private extension PageControlCommandCenter {
    
    func callForPager(next: URL?, onCompletion: @escaping ((Result<Pager, Error>) -> Void)) {
        URLSession.shared.dataTask(with: next ?? self.url) { data, response, error in
            if let error = error {
                onCompletion(.failure(error))
            } else {
                if let data = data {
                    do {
                        let pager = try JSONDecoder().decode(Pager.self, from: data)
                        onCompletion(.success(pager))
                    } catch {
                        onCompletion(.failure(error))
                    }
                } else {
                    onCompletion(.failure(NSError(domain: "pagination", code: 12332, userInfo: nil)))
                }
            }
        }.resume()
    }
}
