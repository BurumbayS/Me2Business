//
//  EditProfileViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/3/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = EditProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
        tableView.registerNib(EditMainInfoTableViewCell.self)
        tableView.register(EditDefaultInfoTableViewCell.self)
        tableView.register(EditAdditionalInfoTableViewCell.self)
    }
    
}

extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch viewModel.sections[section] {
        case .mainInfo:
            return 10
        case .additional:
            return 20
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        
        switch viewModel.sections[section] {
        case .mainInfo:
            header.backgroundColor = .white
        default:
            header.backgroundColor = .clear
        }
        
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.sections[section] {
        case .additional:
            return viewModel.additionalCells.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.sections[indexPath.section]
        
        switch section {
        case .mainInfo:
            
            let cell: EditMainInfoTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
            
        case .additional:
            
            let cell: EditAdditionalInfoTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(title: viewModel.additionalCells[indexPath.row].title)
            return cell
            
        default:
            
            let cell: EditDefaultInfoTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(sectionType: section, data: "")
            return cell
            
        }
    }
}
