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
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerNib(SettingsParameterTableViewCell.self)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.parameters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SettingsParameterTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(parameter: viewModel.parameters[indexPath.row])
        return cell
    }
}
