//
//  EventsTabViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/28/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class EventsTabViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = EventsTabViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
        fetchData()
    }

    private func fetchData() {
        startLoader()
        
        viewModel.getEvents { [weak self] (status, message) in
            switch status {
            case .ok:
                self?.stopLoader()
                self?.tableView.reloadData()
            default:
                self?.stopLoader(withStatus: .fail, andText: message, completion: nil)
            }
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.separatorStyle = .none
        
        tableView.registerNib(EventTableViewCell.self)
    }
}

extension EventsTabViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EventTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(wtih: viewModel.events[indexPath.row])
        return cell
    }
}
