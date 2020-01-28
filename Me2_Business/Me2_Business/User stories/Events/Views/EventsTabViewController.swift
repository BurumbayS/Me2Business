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
    let newEventButton = CustomLargeTitleBarButton()
    
    let viewModel = EventsTabViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
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
    
    private func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "События"
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        search.searchBar.placeholder = "Поиск"
        search.searchBar.setValue("Отменить", forKey: "cancelButtonText")
        navigationItem.searchController = search
        
        newEventButton.add(to: navigationController!.navigationBar, with: UIImage(named: "add_event")!) {
            
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.separatorStyle = .none
        
        tableView.registerNib(EventTableViewCell.self)
        tableView.registerNib(ArchiveTableViewCell.self)
    }
}

extension EventsTabViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        viewModel.searchActivated = false
        tableView.reloadSections([0], with: .automatic)
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }

        if text != "" {
//            viewModel.searchActivated = true
//            viewModel.searchChat(with: text) { [weak self] in
//                self?.tableView.reloadSections([0], with: .automatic)
//            }
        }
    }
}

extension EventsTabViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return viewModel.events.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            
            let cell: ArchiveTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.selectionStyle = .none
            return cell
            
        default:
            
            let cell: EventTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.selectionStyle = .none
            cell.configure(wtih: viewModel.events[indexPath.row])
            return cell
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           guard let height = navigationController?.navigationBar.frame.height else { return }
           newEventButton.moveAndResizeImage(for: height)
       }
}
