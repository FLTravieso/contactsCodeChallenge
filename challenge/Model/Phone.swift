//
//  Phone.swift
//  challenge
//
//  Created by admin on 18/10/18.
//  Copyright © 2018 Frank. All rights reserved.
//

import Foundation

class Phone {
    let work: String?
    let home: String?
    let mobile: String?

    init(data: [String:Any]) {
        self.work = data["work"] as? String ?? nil
        self.home = data["home"] as? String ?? nil
        self.mobile = data["mobile"] as? String ?? nil
    }
}
