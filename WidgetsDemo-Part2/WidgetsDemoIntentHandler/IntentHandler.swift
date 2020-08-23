//
//  IntentHandler.swift
//  WidgetsDemoIntentHandler
//
//  Created by Ritu Bala on 22/08/20.
//

import Intents

class IntentHandler: INExtension, UserCategoriesIntentHandling {
    
    func provideUsersOptionsCollection(for intent: UserCategoriesIntent, with completion: @escaping (INObjectCollection<DynamicUser>?, Error?) -> Void) {
        
        //        URLSession.shared.dataTask(with: yourUrl) { (data, response, error) in
        //
        //        }.resume()
        
        let availableUsers = ["Sunil Gavaskar", "Kapil Dev", "Zaheer Khan", "Anil Kumble"]
        let users: [DynamicUser] = availableUsers.map { usr in
            let user = DynamicUser(identifier: usr, display: usr, pronunciationHint: "")
            return user
        }
        let collection = INObjectCollection(items: users)
        completion(collection, nil)
    }
    
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}
