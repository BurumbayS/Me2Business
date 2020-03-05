//
//  SecurityViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/4/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import Cartography

class SecurityViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = SecurityViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Безопастность"
        
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(SecurityParameterTableViewCell.self)
    }

}

extension SecurityViewController: UITableViewDelegate, UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 100
//    }
//    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footer = UIView()
//        
//        let label = UILabel()
//        label.textColor = .gray
//        label.numberOfLines = 0
//        label.font = UIFont(name: "Roboto-Regular", size: 15)
//        label.text = "Код доступа позволяет быстрый вход в приложение, а также вход по отпечатку пальца TouchID/FaceID."
//        footer.addSubview(label)
//        constrain(label, footer) { label, footer in
//            label.left == footer.left + 20
//            label.right == footer.right - 20
//            label.top == footer.top + 20
//        }
//        
//        return footer
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.parameters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SecurityParameterTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(paramter: viewModel.parameters[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch viewModel.parameters[indexPath.row] {
        case .changePassword:
            let vc = Storyboard.changePasswordViewController()
            navigationController?.pushViewController(vc, animated: true)
        case .changePhone:
            let vc = Storyboard.changePhonenumberViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            return 
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
