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
        extendedLayoutIncludesOpaqueBars = true
        
        navigationController?.navigationBar.tintColor = .black
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "dots_icon"), style: .plain, target: self, action: #selector(doActionOnEvent))
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
    
    @objc private func doActionOnEvent() {
        switch viewModel.event.status {
        case .ACTIVE:
            addActionSheet(titles: ["Поделиться","Изменить","Архивировать"], actions: [shareEvent,editEvent,archiveEvent], styles: [.default,.default,.destructive])
        default:
            addActionSheet(titles: ["Поделиться","Изменить"], actions: [shareEvent,editEvent], styles: [.default,.default])
        }
    }
    
    private func shareEvent() {
        let str = viewModel.event.generateShareInfo()
        
        let activityViewController = UIActivityViewController(activityItems: [str], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    private func editEvent() {
        let navigation = Storyboard.addEventViewController() as! UINavigationController
        let vc = navigation.viewControllers[0] as! AddEventViewController
        vc.viewModel = AddEventViewModel(event: viewModel.event, eventChangesType: .update, onEventAdded: { [weak self] (event) in
//            self?.viewModel.events.insert(event, at: 0)
//            self?.tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
        })
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func archiveEvent() {
        startLoader()
        
        viewModel.archiveEvent { [weak self] (status, message) in
            switch status {
            case .ok:
                self?.stopLoader(withStatus: .success, andText: "Событие архивировано", completion: nil)
                self?.tableView.reloadData()
            default:
                break
            }
        }
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
            cell.configure(event: viewModel.event)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
