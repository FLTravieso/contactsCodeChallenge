//
//  ContactsListPresenter.swift
//  challenge
//
//  Created by admin on 17/10/18.
//  Copyright © 2018 Frank. All rights reserved.
//

import Foundation
import UIKit

class ContactsListPresenter {
    fileprivate weak var contactsListView: ContactsListViewController!
    fileprivate var contacts: [Contact]!
    fileprivate var favoritesContacts: [Contact] = [Contact]()
    fileprivate var otherContacts: [Contact] = [Contact]()
    var sections: [String] = ["Favorite Contacts", "Other Contacts"]

    init(view: ContactsListViewController) {
        self.contactsListView = view
    }

    func start() {
        self.contactsListView.showLoading()
        loadContacts()
    }

    func loadContacts() {
        RequestManager.shared.getJSONRequest {
            response in

            switch response {
            case .success(let contacts):
                self.contacts = contacts.map {
                    $0.smallImage = self.getImage($0.smallImageURL)
                    $0.largeImage = self.getImage($0.largeImageURL)
                    return $0
                }
                self.contacts = contacts.sorted {
                    $0.name < $1.name
                }
                self.favoritesContacts = self.contacts.filter {
                    $0.isFavorite == true
                }
                self.otherContacts = self.contacts.filter {
                    $0.isFavorite == false
                }
                self.contactsListView.contactsList.reloadData()
            case .failure(let message):
                self.contactsListView.showErrorMessage(text: message)
            }

            self.contactsListView.hideLoading()
        }
    }

    func titleForSection(index: Int) -> String  {
        return sections[index]
    }

    func numberOfRowsIn(_ index: Int) -> Int {
        switch index {
        case 0:
            return favoritesContacts.count
        case 1:
            return otherContacts.count
        default:
            return 0
        }
    }

    func prepareCell(for index: IndexPath, to tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCellView") as! ContactCellView
        switch index.section {
        case 0:
            prepareFavoriteContactCell(cell, for: index.row)
        case 1:
            prepareOtherContactCell(cell, for: index.row)
        default:
            return UITableViewCell()
        }

        return cell
    }

    func prepareFavoriteContactCell(_ cell: ContactCellView, for row: Int) {
        cell.name.text = Constants.starChar + self.favoritesContacts[row].name
        cell.company.text = self.favoritesContacts[row].companyName
        cell.contactImage.image = self.favoritesContacts[row].smallImage
    }

    func prepareOtherContactCell(_ cell: ContactCellView, for row: Int) {
        cell.name.text = self.otherContacts[row].name
        cell.company.text = self.otherContacts[row].companyName
        cell.contactImage.image = self.otherContacts[row].smallImage
    }

    func didSelect(_ index: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "ContactDetail", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "ContactDetailViewController") as! ContactDetailViewController
        switch index.section {
        case 0:
            controller.contact = self.favoritesContacts[index.row]
        case 1:
            controller.contact = self.otherContacts[index.row]
        default:
            break
        }
        self.contactsListView.navigationController?.pushViewController(controller, animated: true)
    }

    func getImage(_ iconURL: String?) -> UIImage {
        if let contactImage = iconURL,
            let imageURL = URL(string: contactImage),
            let imageData = NSData(contentsOf: imageURL),
            let mainImage = UIImage(data: imageData as Data) {
            return mainImage
        }
        
        guard let placeholderImage = UIImage(named: "UserIconSmall") else {
            return UIImage()
        }
        return placeholderImage
    }
}
