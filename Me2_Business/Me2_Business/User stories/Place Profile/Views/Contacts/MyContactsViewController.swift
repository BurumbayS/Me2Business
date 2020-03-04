//
//  MyContactsViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/3/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import Cartography

class MyContactsViewController: ListedViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = MyContactsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        fetchData()
    }
    
    private func fetchData() {
        viewModel.getContacts { [weak self] (status, message) in
            switch status {
            case  .ok:
                
                if self?.viewModel.contacts.count == 0 {
                    self?.showEmptyListStatusLabel(withText: "Ваш список контактов пуст")
                } else {
                    self?.hideEmptyListStatusLabel()
                    self?.tableView.reloadData()
                }
                
            case .error:
                break
            case .fail:
                break
            }
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        
        tableView.registerNib(ContactTableViewCell.self)
    }

}

extension MyContactsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        headerView.backgroundColor = Color.lightGray

        let letterLabel = UILabel()
        letterLabel.font = UIFont(name: "Roboto-Regular", size: 13)
        letterLabel.textColor = .gray

        headerView.addSubview(letterLabel)
        constrain(letterLabel, headerView) { letter, view in
            letter.left == view.left + 26
            letter.top == view.top
            letter.bottom == view.bottom
        }
        
        if viewModel.searchActivated {
            letterLabel.text = "Результаты поиска"
        } else {
            letterLabel.text = viewModel.byLetterSections[section].letter
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if viewModel.searchActivated {
            return 1
        } else {
            return viewModel.byLetterSections.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.searchActivated {
            return viewModel.searchResults.count
        } else {
            return viewModel.byLetterSections[section].contacts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : ContactTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let contact = (viewModel.searchActivated) ? viewModel.searchResults[indexPath.row] : viewModel.byLetterSections[indexPath.section].contacts[indexPath.row]
        cell.configure(contact: contact.user2)
        return cell
        
    }
}
