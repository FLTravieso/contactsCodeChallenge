//
//  ContactDetailViewController.swift
//  challenge
//
//  Created by admin on 18/10/18.
//  Copyright © 2018 Frank. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    var contact: Contact!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
    }

    func setupNavBar() {
        let buttonImage = contact.isFavorite ? UIImage(named: "FavoriteTrue")?.withRenderingMode(.alwaysOriginal) : UIImage(named: "FavoriteFalse")?.withRenderingMode(.alwaysOriginal)
        let favorite = UIBarButtonItem(image: buttonImage, style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = favorite
    }

    func setFavoriteButton( isFavorite: Bool) {
        
    }
}
