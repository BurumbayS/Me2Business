//
//  AddEventTagsViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/31/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class AddEventTagsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: EventTagsViewModel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        fetchData()
    }
    
    private func fetchData() {
        startLoader()
        
        viewModel.getTags { [weak self] (status, message) in
            switch status {
            case .ok:
                self?.stopLoader(completion: {
                    self?.tableView.reloadSections([0], with: .automatic)
                })
            default:
                self?.stopLoader(withStatus: .fail, andText: message, completion: nil)
            }
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension AddEventTagsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTagCell", for: indexPath) as! EventTagTableViewCell
        
        cell.selectionStyle = .none
        
        let tag = viewModel.tags[indexPath.row]
        var selected = viewModel.selectedTags.contains(where: { $0.id == tag.id })
        if viewModel.selectedSingleTag != nil {
            selected = tag.id == viewModel.selectedSingleTag!.id
        }
        cell.configure(title: viewModel.tags[indexPath.row].name, selected: selected)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedTag(atIndexPath: indexPath)
        tableView.reloadData()
    }
}
