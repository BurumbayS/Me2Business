//
//  AddEventViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/29/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureNavBar()
    }

    private func configureNavBar() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0);
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.separatorStyle = .none
        
        tableView.registerNib(AddEventMainInfoTableViewCell.self)
        tableView.registerNib(AddEventDateTableViewCell.self)
        tableView.registerNib(AddEventTimeTableViewCell.self)
        tableView.registerNib(AddEventPriceTableViewCell.self)
    }
}

extension AddEventViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = Color.lightGray
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell: AddEventMainInfoTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        case 1:
            let cell: AddEventDateTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        case 2:
            let cell: AddEventTimeTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        case 3:
            let cell: AddEventPriceTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        default:
            return UITableViewCell()
        }
        
    }
}
