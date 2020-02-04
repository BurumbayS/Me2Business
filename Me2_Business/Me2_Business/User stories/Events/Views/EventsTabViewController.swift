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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showNewEventButton(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        showNewEventButton(false)
    }
    
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
        extendedLayoutIncludesOpaqueBars = true
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "События"
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        search.searchBar.placeholder = "Поиск"
        search.searchBar.setValue("Отменить", forKey: "cancelButtonText")
        navigationItem.searchController = search
        
        newEventButton.add(to: navigationController!.navigationBar, with: UIImage(named: "add_event")!) { [weak self] in
            self?.addNewEvent()
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
    
    private func showNewEventButton(_ show: Bool) {
      UIView.animate(withDuration: 0.2) {
          self.newEventButton.alpha = show ? 1.0 : 0.0
      }
    }
    
    private func addNewEvent() {
        let vc = Storyboard.addEventViewController()
        present(vc, animated: true, completion: nil)
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
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        
        switch section {
        case 0:
            footer.backgroundColor = Color.gray
        default:
            footer.backgroundColor = .white
        }
        
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            
            let vc = Storyboard.archivedEventsViewController() as! ArchivedEventsViewController
            vc.events = viewModel.archivedEvents
            self.navigationController?.pushViewController(vc, animated: true)
            
        default:
            
            let vc = Storyboard.eventInfoViewController() as! EventInfoViewController
            vc.viewModel = EventInfoViewModel(event: viewModel.events[indexPath.row])
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           guard let height = navigationController?.navigationBar.frame.height else { return }
           newEventButton.moveAndResizeImage(for: height)
       }
}
