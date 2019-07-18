//
//  EdamamAPI.swift
//  SmartList
//
//  Created by Oleksandr Gribov on 7/16/19.
//  Copyright © 2019 Oleksandr Gribov. All rights reserved.
//

import Foundation

struct EdamamAPI {
    
    static var upcCode: String?
    
    static func makeURL () -> URL? {
        
        if let upcCode = upcCode {
            var listURLComponents = URLComponents()
            listURLComponents.scheme = "https"
            listURLComponents.host = "api.edamam.com"
            listURLComponents.path = "/api/food-database/parser"
            
            
            var mQueries = [
                "upc": "\(upcCode)",
                "app_id": "7d6d071a",
                "app_key": "3043732519b15038294a96822d39381f"
                
            ]
            
            listURLComponents.searchParams(mQueries)
            guard let urlString = listURLComponents.url?.absoluteString else {
                return nil
            }
            let url = URL(string: urlString)!
            return url
        } else {
            return nil
        }
    }
    
    // TODO: add completion handler 
    static func processJSON(_ data: Data ) -> Item? {
        var item : Item!
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            if let dict = jsonObject as? [String:AnyObject] {
                print (dict["text"])
                if let hints = dict["hints"] as? [AnyObject] {
                    print(hints.count)
                    
                    guard
                        let foodList = hints[0] as? [String:AnyObject],
                        let food = foodList["food"],
                        let name = food["label"] as? String,
                        let imageURL = food["image"] as? String else {
                            return nil
                    }
                    item = Item(name: name)
                    item.imageURL = URL(string: imageURL)
                }
            }
        }catch {
            print(error)
        }
        print("Product name: \(item.name) \nImageURL: \(item.imageURL)")
        return item
        
    }
    
    static func fetchProductData(completion: @escaping (Item?) -> Void) {
        let url = makeURL()
        
        if let url = url {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let product =  processJSON(data)
                    completion(product)
                }
            }
            task.resume()
        }
    }
}

extension URLComponents {
    mutating func searchParams (_ queries: [String:String]) {
        self.queryItems = queries.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
