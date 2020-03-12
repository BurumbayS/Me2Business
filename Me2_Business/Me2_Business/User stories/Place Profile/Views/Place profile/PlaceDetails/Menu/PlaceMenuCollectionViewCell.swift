//
//  PlaceMenuCollectionViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 2/29/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import Cartography
import SafariServices

class PlaceMenuCollectionViewCell: PlaceDetailCollectionCell {
    
    let tableView = TableView()
    let placeholderLabel = UILabel()
    
    let titles = ["Меню Traveler's Coffee","Бар Меню"]
    var menus = [Menu]()
    var tableSize: Dynamic<CGSize>?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
        configureTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        self.contentView.backgroundColor = .white
        
        placeholderLabel.textColor = .darkGray
        placeholderLabel.font = UIFont(name: "Roboto-Regular", size: 17)
        placeholderLabel.text = "Пока нет меню"
        placeholderLabel.isHidden = true
        self.contentView.addSubview(placeholderLabel)
        constrain(placeholderLabel, self.contentView) { label, view in
            label.centerX == view.centerX
            label.top == view.top + 50
        }
        
        self.contentView.addSubview(tableView)
        constrain(tableView, self.contentView) { table, view in
            table.left == view.left
            table.right == view.right
            table.top == view.top
            table.bottom == view.bottom
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        
        tableView.register(MenuFileTableViewCell.self)
    }
    
    func configure(itemSize: Dynamic<CGSize>?, menus: [Menu], presenterDelegate: ControllerPresenterDelegate) {
        self.presenterDelegate = presenterDelegate
        self.tableSize = itemSize
        self.menus = menus
        
        if menus.count > 0 {
            tableView.reloadSections([0], with: .automatic)
            tableView.isHidden = false
            placeholderLabel.isHidden = true
        } else {
            tableView.isHidden = true
            placeholderLabel.isHidden = false
        }
    }
    
    override func reload () {
        tableView.reloadDataWithCompletion {
            let fullTableViewSize = CGSize(width: self.tableView.contentSize.width, height: self.tableView.contentSize.height + self.tableView.contentInset.bottom)
            self.tableSize?.value = (Constants.shared.minContentSize.height < fullTableViewSize.height) ? fullTableViewSize : Constants.shared.minContentSize
            print("Table view reloaded")
            let data = ["tableViewHeight": self.tableView.contentSize.height]
            NotificationCenter.default.post(name: .updateCellheight, object: nil, userInfo: data)
        }
    }
}

extension PlaceMenuCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MenuFileTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        
        let menu = menus[indexPath.row]
        cell.configure(menu: menu)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: menus[indexPath.row].file) else { return }
        let svc = SFSafariViewController(url: url)
        presenterDelegate.present(controller: svc, presntationType: .present, completion: nil)
    }
}
