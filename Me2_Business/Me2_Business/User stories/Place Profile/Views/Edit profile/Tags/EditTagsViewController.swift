//
//  EditTagsViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/6/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class EditTagsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = EditTagsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureTableView()
    }

    private func configureNavBar() {
        removeBackButton()
        
        navigationItem.title = "Тэги"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(completeEditing))
        navigationItem.rightBarButtonItem?.tintColor = Color.blue
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerNib(EditTagsTableViewCell.self)
    }
    
    @objc private func completeEditing() {
        
    }
    
}

extension EditTagsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.parameters[indexPath.row].cellType {
        case .withPrice:
            return 70
        default:
            return 55
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.parameters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EditTagsTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(parameter: viewModel.parameters[indexPath.row])
        return cell
    }
}
