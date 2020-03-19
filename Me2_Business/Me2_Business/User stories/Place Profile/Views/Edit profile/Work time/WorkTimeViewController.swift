//
//  WorkTimeViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/5/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import Cartography

class WorkTimeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: EditWorlTimeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureTableView()
    }
    
    private func configureNavBar() {
        navigationItem.title = "График работы"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(completeEditing))
        navigationItem.rightBarButtonItem?.tintColor = Color.blue
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerNib(EditableWorkTimeTableViewCell.self)
    }
    
    @objc private func completeEditing() {
        viewModel.completeEditing()
        self.navigationController?.popViewController(animated: true)
    }
}

extension WorkTimeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weekdays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EditableWorkTimeTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.selectionStyle = .none
        let weekday = viewModel.editedWorkingHours.weekDays[indexPath.row]
        cell.configure(weekDay: weekday, onDayNnightSelected: { [weak self] in
            self?.viewModel.editedWorkingHours.weekDays[indexPath.row].dayNnight = !(self?.viewModel.editedWorkingHours.weekDays[indexPath.row].dayNnight ?? false)
            self?.tableView.reloadData()
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.editedWorkingHours.weekDays[indexPath.row].works = !viewModel.editedWorkingHours.weekDays[indexPath.row].works
        tableView.reloadData()
    }
}
