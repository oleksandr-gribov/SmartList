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
    var imageKey: String?
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.completed, forKey:"completed")
        aCoder.encode(self.uID, forKey: "uID")
        if let imageKey = imageKey {
            aCoder.encode(imageKey,forKey: "imageKey")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey:"name") as! String
        completed = aDecoder.decodeBool(forKey: "completed")
        uID = aDecoder.decodeObject(forKey: "uID") as? String ?? UUID().uuidString
        imageKey = aDecoder.decodeObject(forKey: "imageKey") as? String ?? nil
       
    }
    
   
    
    init( name: String ) {
        self.name = name
        self.completed = false
        self.uID = UUID().uuidString
    }
}

extension Item: Comparable {
    static func < (lhs: Item, rhs: Item) -> Bool {
        if lhs.completed == true && rhs.completed == false {
            return false
        } else if lhs.completed == false && rhs.completed == true {
            return true
        } else {
            return true
        }
    }
    
    
}
