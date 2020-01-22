//
//  ApplicationViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/9/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import Cartography

class ApplicationViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    
    let sendButton = UIButton()
    let errorLabel = UILabel()
    
    let viewModel = ApplicationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBackBarButton(for: navItem)
        configureTableView()
        configureNavBar()
        bindDynamics()
    }
    
    private func configureNavBar() {
        navBar.tintColor = .black
        navItem.title = "Заявка на регистрацию"
        setUpBackBarButton(for: navItem)
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        
        tableView.registerNib(ApplicationFieldTableViewCell.self)
    }
    
    private func bindDynamics() {
        viewModel.allFieldsCorrect.bind { [weak self] (correct) in
            if correct {
                self?.sendButton.enable()
                self?.errorLabel.text = ""
            } else {
                self?.sendButton.disable()
                self?.errorLabel.text = "Заполните все поля"
            }
        }
    }
    
    @objc private func sendApplication() {
        startLoader()
        
        viewModel.sendApplication { [weak self] (status, message) in
            switch status {
            case .ok:
                self?.stopLoader(withStatus: .success, andText: "Ваша заявка отправлена успешно. Наш менеджер свяжется с Вами в ближайшее время.", completion: {
                    self?.navigationController?.popViewController(animated: true)
                })
            case .error:
                self?.stopLoader(withStatus: .fail, andText: message, completion: nil)
            default:
                self?.stopLoader(withStatus: .fail, andText: "Упс... что-то пошло не так. Проверьте соединение с интернетом или повторите попытку.", completion: nil)
            }
        }
    }

}

extension ApplicationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        
        sendButton.layer.cornerRadius = 10
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.setTitle("Отправить", for: .normal)
        sendButton.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 20)
        sendButton.backgroundColor = Color.red
        sendButton.disable()
        sendButton.addTarget(self, action: #selector(sendApplication), for: .touchUpInside)
        footer.addSubview(sendButton)
        constrain(sendButton, footer) { btn, footer in
            btn.top == footer.top + 30
            btn.centerX == footer.centerX
            btn.height == 45
            btn.width == UIScreen.main.bounds.width * 0.6
        }
        
        errorLabel.textColor = Color.red
        errorLabel.font = UIFont(name: "Roboto-Regular", size: 13)
        footer.addSubview(errorLabel)
        constrain(errorLabel, sendButton, footer) { label, btn, footer in
            label.top == btn.bottom + 20
            label.centerX == footer.centerX
            label.height == 15
            label.bottom == footer.bottom
        }
        
        return footer
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.fields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ApplicationFieldTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.selectionStyle = .none
        let field = viewModel.fields[indexPath.row]
        cell.configure(field: field, data: viewModel.fieldsData[field] ?? Dynamic(""), filledCorrect: viewModel.fieldsCorrectness[field] ?? Dynamic(false))
        return cell
    }
}
