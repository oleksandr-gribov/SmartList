//
//  List.swift
//  SmartList
//
//  Created by Oleksandr Gribov on 4/24/20.
//  Copyright © 2020 Oleksandr Gribov. All rights reserved.
//

import Foundation

struct List {
    var uid: UUID
    var name: String
    var date: Date
    var items: [Item]
    var accessedBy: [String]
    
    init(_ name: String, date: Date) {
        self.uid = UUID()
        self.name = name
        self.date = date
        self.items = []
        self.accessedBy = []
    }
}
