//
//  Address.swift
//  challenge
//
//  Created by admin on 18/10/18.
//  Copyright © 2018 Frank. All rights reserved.
//

import Foundation

class Address {
    let street: String?
    let city: String?
    let state: String?
    let country: String?
    let zipCode: String?

    init(data: [String:Any]) {
        self.street = data["street"] as? String ?? nil
        self.city = data["city"] as? String ?? nil
        self.state = data["state"] as? String ?? nil
        self.country = data["country"] as? String ?? nil
        self.zipCode = data["zipCode"] as? String ?? nil
    }
}
