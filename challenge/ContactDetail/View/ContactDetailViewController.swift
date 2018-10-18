//
//  ContactDetailViewController.swift
//  challenge
//
//  Created by admin on 18/10/18.
//  Copyright © 2018 Frank. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    fileprivate var presenter: ContactDetailPresenter!
    var contact: Contact!

    @IBOutlet weak var contactInfo: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = ContactDetailPresenter(view: self, contact: self.contact)
        setupNavBar()
        setupTableView()
        presenter.start(with: self.contactInfo)
        
    }

    func setupNavBar() {
        let buttonImage = contact.isFavorite ? UIImage(named: "FavoriteTrue")?.withRenderingMode(.alwaysOriginal) : UIImage(named: "FavoriteFalse")?.withRenderingMode(.alwaysOriginal)
        let favorite = UIBarButtonItem(image: buttonImage, style: .plain, target: self, action: #selector(favButtonPressed))
        self.navigationItem.rightBarButtonItem = favorite
    }

    @objc func favButtonPressed() {
        guard let item = self.navigationItem.rightBarButtonItem else {
            return
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "favButtonPressed"),
                                        object: nil, userInfo: ["id": contact.id])
        item.image = contact.isFavorite ? UIImage(named: "FavoriteTrue")?.withRenderingMode(.alwaysOriginal) : UIImage(named: "FavoriteFalse")?.withRenderingMode(.alwaysOriginal)
    }

    func setupTableView() {
        self.contactInfo.dataSource = self
        self.contactInfo.tableFooterView = UIView()
        self.contactInfo.allowsSelection = false
        var bundle = Bundle(for: HeaderCell.self)
        var nibFile = UINib(nibName: "HeaderCell", bundle: bundle)
        contactInfo.register(nibFile, forCellReuseIdentifier: "HeaderCell")
        bundle = Bundle(for: CustomCell.self)
        nibFile = UINib(nibName: "CustomCell", bundle: bundle)
        contactInfo.register(nibFile, forCellReuseIdentifier: "CustomCell")
    }
}

extension ContactDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter.rows[indexPath.row]
    }
    
    
}
