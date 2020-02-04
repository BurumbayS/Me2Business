//
//  ArchivedEventsViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/28/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class ArchivedEventsViewController: ListedViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var events = [Event]()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureTableView()
    }

    private func configureNavBar() {
        extendedLayoutIncludesOpaqueBars = true
        
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "Архив"
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        
        tableView.registerNib(EventTableViewCell.self)
        
        if events.count > 0 {
            tableView.reloadSections([0], with: .automatic)
        } else {
            showEmptyListStatusLabel(withText: "Архив пуст")
        }
    }
}

extension ArchivedEventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EventTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.selectionStyle = .none
        cell.configure(wtih: events[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Storyboard.eventInfoViewController() as! EventInfoViewController
        vc.viewModel = EventInfoViewModel(event: events[indexPath.row], onEventArchived: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
