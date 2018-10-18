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
        let favorite = UIBarButtonItem(image: buttonImage, style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = favorite
    }

    func setFavoriteButton( isFavorite: Bool) {
        
    }

    func setupTableView() {
        self.contactInfo.dataSource = self
        let bundle = Bundle(for: HeaderCell.self)
        let nibFile = UINib(nibName: "HeaderCell", bundle: bundle)
        contactInfo.register(nibFile, forCellReuseIdentifier: "HeaderCell")
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
