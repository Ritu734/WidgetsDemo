//
//  WebService.swift
//  SimpleWidgetExtension
//
//  Created by Ritu Bala on 20/08/20.
//

import Foundation

let configUrl = URLRequest(url: URL(string: "https://...")!)

struct User: Codable {
    var name: String
    var profession: String
}

extension User {
    static let demoJson = User(name: "Sachin Tendulkar", profession: "Cricket")
    static let demoData = try! JSONEncoder().encode(demoJson)
}

class WebService {
    
    static func fetchUserData(completion:@escaping (User?, Error?) -> Void) {
        
//        URLSession.shared.dataTask(with: configUrl) { (data, response, error) in
//
//        }.resume()
        
        let parsedData = try! JSONDecoder().decode(User.self, from: User.demoData)
        completion(parsedData, nil)
    }
}


