//
//  SearchObject.swift
//  Pokemon
//
//  Created by Darshan S on 10/02/24.
//

import Foundation

@MainActor 
class SearchObject<T: TableObject,E: TableObservableObject>: ObservableObject where E.T == T {
    
    weak var tableObservable: E?
    
    @Published var searchedObjects: [T] = []
    @Published var query: String = ""
    @Published var page: Int = 1
    
    init(tableObservable: E) {
        self.tableObservable = tableObservable
    }
    
    func find() async {
        self.searchedObjects = await tableObservable?.findObjects(query) ?? []
//        tableObservable?.findObjects(query, onCompletion: { [weak self] objects  in
//            self?.searchedObjects = objects
//        })
    }
}
