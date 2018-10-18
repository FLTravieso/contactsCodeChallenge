//
//  ContactDetailPresenter.swift
//  challenge
//
//  Created by admin on 18/10/18.
//  Copyright © 2018 Frank. All rights reserved.
//

import Foundation
import UIKit

class ContactDetailPresenter {
    fileprivate weak var contactDetailView: ContactDetailViewController!
    fileprivate var contact: Contact!
    var rows: [UITableViewCell] = [UITableViewCell]()

    init(view: ContactDetailViewController, contact: Contact) {
        self.contactDetailView = view
        self.contact = contact
    }

    func start(with tableview: UITableView) {
        prepareHeaderCell(tableview)
    }

    func prepareHeaderCell(_ tableview: UITableView) {
        let cell = tableview.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
        cell.contactImage.image = contact.largeImage
        cell.name.text = contact.name
        cell.company.text = contact.companyName
        self.rows.append(cell)
    }
}
