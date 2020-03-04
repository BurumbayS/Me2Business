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
        
        configureNavBar()
        configureTableView()
        fetchData()
    }
    
    private func fetchData() {
        viewModel.getContacts { [weak self] (status, message) in
            switch status {
            case  .ok:
                
                if self?.viewModel.contacts.count == 0 {
                    self?.showEmptyListStatusLabel(withText: "Ваш список контактов пуст")
                    self?.navigationItem.rightBarButtonItem?.isEnabled = false
                } else {
                    self?.hideEmptyListStatusLabel()
                    self?.navigationItem.rightBarButtonItem?.isEnabled = true
                    self?.tableView.reloadData()
                }
                
            case .error:
                break
            case .fail:
                break
            }
        }
    }
    
    private func configureNavBar() {
        navigationItem.title = "Контакты"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editContactsList))
        navigationItem.rightBarButtonItem?.tintColor = Color.blue
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        
        tableView.registerNib(ContactTableViewCell.self)
    }
    
    @objc private func editContactsList() {
        if viewModel.contactsListEditing {
            deleteContacts()
        } else {
            viewModel.contactsListEditing = true
            
            navigationItem.rightBarButtonItem?.title = "Удалить"
            navigationItem.rightBarButtonItem?.tintColor = Color.red
            navigationItem.rightBarButtonItem?.isEnabled = false
            
            let leftBarButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelEditing))
            leftBarButton.tintColor = Color.blue
            navigationItem.leftBarButtonItem = leftBarButton
            
            tableView.reloadData()
        }
    }
    
    @objc private func cancelEditing() {
        viewModel.contactsListEditing = false
        viewModel.contactsToDelete = []
        
        navigationItem.rightBarButtonItem?.title = "Править"
        navigationItem.rightBarButtonItem?.tintColor = Color.blue
        navigationItem.rightBarButtonItem?.isEnabled = true
        
        navigationItem.leftBarButtonItem = nil
        
        tableView.reloadData()
    }
    
    private func deleteContacts() {
        viewModel.deleteContacts { [weak self] (status, message) in
            switch status {
            case .ok:
                
                self?.cancelEditing()
                
            case .error:
                break
            case .fail:
                break
            }
        }
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
        cell.configure(contact: contact.user2, selectable: viewModel.contactsListEditing)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        if !viewModel.contactsListEditing {
//
//            let navigationController = Storyboard.userProfileViewController() as! UINavigationController
//            let vc = navigationController.viewControllers[0] as! UserProfileViewController
//            vc.viewModel = UserProfileViewModel(userID: viewModel.byLetterSections[indexPath.section]?.contacts[indexPath.row].user2.id ?? 0, profileType: .guestProfile)
//            self.navigationController?.pushViewController(vc, animated: true)
//
//        } else {
            
            let cell = tableView.cellForRow(at: indexPath) as! ContactTableViewCell
            viewModel.select(cell: cell, atIndexPath: indexPath)
            navigationItem.rightBarButtonItem?.isEnabled = (viewModel.contactsToDelete.count > 0)
            
//        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
