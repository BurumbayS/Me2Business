//
//  SettingsViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/2/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = SettingsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        configureTableView()
        configureNavBar()
    }

    private func configureNavBar() {
        navigationItem.title = "Настройки аккаунта"
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 60
        
        tableView.registerNib(SettingsParameterTableViewCell.self)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.parameters.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SettingsParameterTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.selectionStyle = .none
        cell.configure(parameter: viewModel.parameters[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch viewModel.parameters[indexPath.row] {
        case .edit:
            let vc = Storyboard.editProfileViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }
}
