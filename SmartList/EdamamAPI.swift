//
//  EdamamAPI.swift
//  SmartList
//
//  Created by Oleksandr Gribov on 7/16/19.
//  Copyright © 2019 Oleksandr Gribov. All rights reserved.
//

import Foundation

class EdamamAPI {
    
    static var upcCode: String?
    
    private static func makeURL () -> URL? {
        
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
    
    private static func fetchProductData() {
        let url = makeURL()
        
        if let url = url {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    print(String(data: data, encoding: .utf8))
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
