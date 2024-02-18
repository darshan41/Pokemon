//
//  HomeModel.swift
//  Pokemon
//
//  Created by Darshan S on 18/02/24.
//

import Foundation

class HomeModel {
    
    weak var context: CoreDataStackManagible?
    
    init(context: CoreDataStackManagible? = nil) {
        self.context = context
    }
}

