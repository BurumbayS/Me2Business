//
//  ComplaintViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/24/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import Cartography

class ComplaintViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: UserComplaintViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureTableView()
    }

    private func configureNavBar() {
        navBar.tintColor = .black
        navItem.title = "Пожаловаться"
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelComplaint))
        navItem.leftBarButtonItem?.tintColor = Color.red
        
        navItem.rightBarButtonItem = UIBarButtonItem(title: "Отправить", style: .plain, target: self, action: #selector(completeComplaint))
        navItem.rightBarButtonItem?.tintColor = Color.blue
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerNib(ComplaintReasonTableViewCell.self)
    }
    
    @objc private func cancelComplaint() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func completeComplaint() {
        startLoader()
        
        viewModel.complainToUser(withText: viewModel.reasons[viewModel.selectedReasonIndex]) { [weak self] (status, message) in
            switch status {
            case .ok:
                self?.stopLoader(withStatus: .success, andText: "Благодарим за сообщение! Мы обязательно рассмотрим Вашу жалобу.", completion: {
                    self?.dismiss(animated: true, completion: nil)
                })
            default:
                self?.stopLoader(withStatus: .fail, andText: message, completion: nil)
            }
        }
    }
}

extension ComplaintViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        
        let title = UILabel()
        title.textColor = .gray
        title.font = UIFont(name: "Roboto-Regular", size: 15)
        title.text = "Укажите причину удаления аккаунта"
        
        header.addSubview(title)
        constrain(title, header) { title, header in
            title.left == header.left + 20
            title.top == header.top + 20
            title.bottom == header.bottom - 10
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.reasons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ComplaintReasonTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let isSelected = viewModel.selectedReasonIndex == indexPath.row
        cell.selectionStyle = .none
        cell.configure(text: viewModel.reasons[indexPath.row], selected: isSelected)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedReasonIndex = indexPath.row
        tableView.reloadData()
    }
}
