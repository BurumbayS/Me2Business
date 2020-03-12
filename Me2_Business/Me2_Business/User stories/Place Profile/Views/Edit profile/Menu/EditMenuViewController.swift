//
//  EditMenuViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/12/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import SafariServices

class EditMenuViewController: ListedViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: EditMenuViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configureNavBar()
        configureTableView()
        configureViews()
    }
    
    private func configureNavBar() {
        navigationItem.title = "Меню"
    }
    
    private func configureViews() {
        if viewModel.placeInfo.menus!.count == 0 {
            showEmptyListStatusLabel(withText: "Пока меню отсутствует")
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        
        tableView.register(MenuFileTableViewCell.self)
    }
    
}

extension EditMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.placeInfo.menus?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MenuFileTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.selectionStyle = .none
        cell.configure(menu: (viewModel.placeInfo.menus?[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: viewModel.placeInfo.menus?[indexPath.row].file ?? "") else { return }
        let svc = SFSafariViewController(url: url)
        self.present(svc, animated: true, completion: nil)
    }
}
