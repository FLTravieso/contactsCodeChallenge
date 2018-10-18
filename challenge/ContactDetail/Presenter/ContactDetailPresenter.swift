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
        preparePhoneCells(tableview)
        prepareAddressCell(tableview)
        prepareBirthdayCell(tableview)
        prepareEmailCell(tableview)
    }

    func prepareHeaderCell(_ tableview: UITableView) {
        let cell = tableview.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
        cell.contactImage.image = contact.largeImage
        cell.name.text = contact.name
        cell.company.text = contact.companyName
        self.rows.append(cell)
    }

    func prepareEmailCell(_ tableview: UITableView) {
        let cell = tableview.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        cell.title.text = "Email"
        cell.info.text = contact.email
        cell.type.isHidden = true
        self.rows.append(cell)
    }

    func preparePhoneCells(_ tableview: UITableView) {
        if let homePhone = contact.phone?.home {
            let cell = tableview.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
            cell.title.text = "Phone"
            cell.info.text = homePhone
            cell.type.text = "Home"
            self.rows.append(cell)
        }

        if let mobilePhone = contact.phone?.mobile {
            let cell = tableview.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
            cell.title.text = "Phone"
            cell.info.text = mobilePhone
            cell.type.text = "Mobile"
            self.rows.append(cell)
        }

        if let workPhone = contact.phone?.work {
            let cell = tableview.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
            cell.title.text = "Phone"
            cell.info.text = workPhone
            cell.type.text = "Work"
            self.rows.append(cell)
        }
    }

    func prepareAddressCell(_ tableview: UITableView) {
        let cell = tableview.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        cell.title.text = "Address"
        cell.info.text = getAddress()
        cell.type.isHidden = true
        self.rows.append(cell)
    }

    func prepareBirthdayCell(_ tableview: UITableView) {
        let cell = tableview.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        cell.title.text = "Birthday"
        cell.info.text = getBirthday()
        cell.type.isHidden = true
        self.rows.append(cell)
    }

    func getAddress() -> String? {
        guard let address = contact.address else {
            return nil
        }

        let completeAddress = [address.street, address.city, address.state, address.zipCode, address.country].compactMap { $0 }
            .joined(separator: ", ")

        return completeAddress
    }

    func getBirthday() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = contact.birthdate,
            let auxDate = dateFormatter.date(from: date) else {
            return nil
        }

        dateFormatter.dateFormat = "MMMM"
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: auxDate)
        let month = dateFormatter.string(from: auxDate).capitalized

        guard let day = components.day,
            let year = components.year else {
                return nil
        }
        return "\(month) \(day), \(year)"
    }
}
