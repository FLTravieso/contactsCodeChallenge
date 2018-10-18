//
//  ViewController.swift
//  challenge
//
//  Created by admin on 17/10/18.
//  Copyright © 2018 Frank. All rights reserved.
//

import UIKit

class ContactsListViewController: UIViewController {

    fileprivate var presenter: ContactsListPresenter!
    @IBOutlet weak var contactsList: UITableView!
    @IBOutlet weak var waiting: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.presenter = ContactsListPresenter(view: self)
        self.presenter.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupTableView() {
        self.contactsList.dataSource = self
        self.contactsList.delegate = self
        let bundle = Bundle(for: ContactCellView.self)
        let nibFile = UINib(nibName: "ContactCellView", bundle: bundle)
        contactsList.register(nibFile, forCellReuseIdentifier: "ContactCellView")
    }

    func showLoading() {
        self.waiting.isHidden = false
        self.spinner.startAnimating()
    }

    func hideLoading() {
        self.waiting.isHidden = true
        self.spinner.stopAnimating()
    }

    func showErrorMessage(text: String) {
        let errorAlert = UIAlertController(title: Constants.errorTitle, message: text, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: Constants.okText, style: .default, handler: nil)
        errorAlert.addAction(dismiss)
        self.present(errorAlert, animated: true, completion: nil)
    }
}

extension ContactsListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsIn(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter.prepareCell(for: indexPath, to: contactsList)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.titleForSection(index: section)
    }
}

extension ContactsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

