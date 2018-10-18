//
//  Contact.swift
//  challenge
//
//  Created by admin on 18/10/18.
//  Copyright © 2018 Frank. All rights reserved.
//

import Foundation
import UIKit

class Contact {
    let id: String!
    let name: String!
    let companyName: String?
    let isFavorite: Bool?
    let smallImageURL: String?
    let largeImageURL: String?
    var smallImage: UIImage!
    var largeImage: UIImage!
    let email: String?
    let birthdate: String?
    var phone: Phone?
    var address: Address?

    init(data: [String: Any]) {
        self.id = data["id"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.companyName = data["companyName"] as? String
        self.isFavorite = data["isFavorite"] as? Bool
        self.smallImageURL = data["smallImageURL"] as? String
        self.largeImageURL = data["largeImageURL"] as? String
        self.email = data["emailAddress"] as? String
        self.birthdate = data["birthdate"] as? String

        if let phone = data["phone"] as? [String : Any] {
            self.phone = Phone(data: phone)
        }

        if let address = data["address"] as? [String : Any] {
            self.address = Address(data: address)
        }
    }
}
