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
        
        fetchData()
    }
    
    private func fetchData() {
        startLoader()
        
        viewModel.fetchData { [weak self] (status, message) in
            switch status {
            case .ok:
                self?.stopLoader()
                self?.tableView.reloadData()
            default:
                self?.stopLoader(withStatus: .fail, andText: message, completion: nil)
            }
        }
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
        tableView.register(TagsTableViewCell.self)
    }
}

extension EventInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.dataLoaded { return 4 } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell: EventInfoHeaderTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(event: viewModel.event)
            return cell
        case 1:
            let cell: TagsTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(tagsType: .normal, tagsList: viewModel.getTagsList())
            return cell
        case 2:
            let cell: EventLocationAndWorkTimeTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(location: viewModel.event.place.address1, time: viewModel.event.getTime())
            return cell
        case 3:
            let cell: EventAdditionalInfoTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
