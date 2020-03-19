//
//  PlaceTagsListViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/10/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class PlaceTagsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: PlaceTagsListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        fetchData()
    }
    
    private func fetchData() {
        viewModel.getTags { [weak self] (status, message) in
            switch status {
            case .ok:
                self?.tableView.reloadSections([0], with: .automatic)
            default:
                break
            }
        }
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension PlaceTagsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tagsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceTagCell", for: indexPath) as! PlaceTagTableViewCell
        
        cell.selectionStyle = .none
        let selected = viewModel.data.tagIDs.contains(viewModel.tagsList[indexPath.row].id)
        cell.configure(title: viewModel.tagsList[indexPath.row].name, selected: selected)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectTag(atIndex: indexPath.row)
        tableView.reloadData()
    }
}
