//
//  Item.swift
//  SmartList
//
//  Created by Oleksandr Gribov on 3/22/19.
//  Copyright © 2019 Oleksandr Gribov. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
    var name : String
    var completed: Bool
    var uID: String
    var imageURL: URL?
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.completed, forKey:"completed")
        aCoder.encode(self.uID, forKey: "uID")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey:"name") as! String
        completed = aDecoder.decodeBool(forKey: "completed")
        uID = aDecoder.decodeObject(forKey: "uID") as? String ?? UUID().uuidString
    }
    
   
    
    init( name: String ) {
        self.name = name
        self.completed = false
        self.uID = UUID().uuidString
    }
    
}
