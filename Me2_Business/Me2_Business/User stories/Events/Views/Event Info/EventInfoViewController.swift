//
//  EventInfoViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/28/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class EventInfoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: EventInfoViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureNavBar()
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.largeTitleDisplayMode = .never
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        
        tableView.registerNib(EventInfoHeaderTableViewCell.self)
        tableView.registerNib(EventLocationAndWorkTimeTableViewCell.self)
        tableView.registerNib(EventAdditionalInfoTableViewCell.self)
    }
}

extension EventInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell: EventInfoHeaderTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(event: viewModel.event)
            return cell
        case 1:
            let cell: EventLocationAndWorkTimeTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(location: viewModel.event.place.address1, time: viewModel.event.getTime())
            return cell
        case 2:
            let cell: EventAdditionalInfoTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
