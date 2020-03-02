//
//  PlaceInfoCollectionViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 2/27/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import Cartography
import SafariServices

class PlaceInfoCollectionViewCell: PlaceDetailCollectionCell {
    
    let tableView = TableView()
    var tableSize: Dynamic<CGSize>?
    
    var viewModel: PlaceInfoViewModel!
    
    var parentVC: UIViewController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
        configureTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(itemSize: Dynamic<CGSize>?, place: Place, presenterDelegate: ControllerPresenterDelegate, viewController: UIViewController) {
        self.presenterDelegate = presenterDelegate
        self.tableSize = itemSize
        self.viewModel = PlaceInfoViewModel(place: place)
        self.parentVC = viewController
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
    
    private func setUpViews() {
        self.contentView.addSubview(tableView)
        configureViews()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.isScrollEnabled = false
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        tableView.register(PlaceDescriptionTableViewCell.self)
        tableView.register(AdressTableViewCell.self)
        tableView.register(PlaceWorkTimeTableViewCell.self)
        tableView.register(TagsTableViewCell.self)
        tableView.register(AdditionalPlaceInfoTableViewCell.self)
    }
    
    private func configureViews() {
        constrain(tableView, self.contentView) { table, view in
            table.left == view.left
            table.right == view.right
            table.top == view.top
            table.bottom == view.bottom
        }
    }
}

extension PlaceInfoCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.placeSections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.placeSections[indexPath.row] {
        case .description:
            
            let cell: PlaceDescriptionTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.selectionStyle = .none
            cell.configure(with: viewModel.placeInfo.description ?? "") { [weak self] in
                self?.tableView.beginUpdates()
                    cell.updateUI()
                self?.tableView.endUpdates()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                    self?.reload()
                })
            }
            return cell
            
        case .address:
            
            let cell: AdressTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.selectionStyle = .none
            cell.configure(with: viewModel.placeInfo.address1, additionalInfo: viewModel.placeInfo.address2)
            return cell
            
        case .workTime:
            
            let cell: PlaceWorkTimeTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.selectionStyle = .none
            cell.configure(with: viewModel.placeInfo.workingHours)
            return cell
            
        case .phone, .mail, .site, .instagram:
            
            let cell: AdditionalPlaceInfoTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
            
        case .tags:
            
            let cell: TagsTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(tagsType: .unselectable, tagsList: TagsList(items: viewModel.placeInfo.tags))
            cell.selectionStyle = .none
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch viewModel.placeSections[indexPath.row] {
        case .site:
            
            guard let url = URL(string: viewModel.placeInfo.website ?? "") else { return }
            let svc = SFSafariViewController(url: url)
            
            presenterDelegate.present(controller: svc, presntationType: .present, completion: nil)
        case .mail:
            
            let email = viewModel.placeInfo.email
            if let url = URL(string: "mailto:\(email!)") {
              if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
              } else {
                UIApplication.shared.openURL(url)
              }
            }
            
//        case .address:
//            
//            let vc = Storyboard.placeOnMapViewController() as! PlaceOnMapViewController
//            vc.place = viewModel.placeInfo
//            presenterDelegate.present(controller: vc, presntationType: .push, completion: nil)
            
        default:
            break
        }
    }
}

