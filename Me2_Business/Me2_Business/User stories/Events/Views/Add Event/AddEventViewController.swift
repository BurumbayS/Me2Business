//
//  AddEventViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/29/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = AddEventViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureNavBar()
    }

    private func configureNavBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .black
        
        navigationItem.title = "Новое событие"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelCreating))
        navigationItem.leftBarButtonItem?.tintColor = Color.red
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Создать", style: .plain, target: self, action: #selector(completeCreating))
        navigationItem.rightBarButtonItem?.tintColor = Color.blue
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.separatorStyle = .none
        
        tableView.registerNib(AddEventMainInfoTableViewCell.self)
        tableView.registerNib(AddEventDateTableViewCell.self)
        tableView.registerNib(AddEventTimeTableViewCell.self)
        tableView.registerNib(AddEventPriceTableViewCell.self)
    }
    
    @objc private func cancelCreating() {
        showDefaultAlert(title: "", message: "Вы уверены, что хотите отменить действие? Введенные Вами данные не будут сохранены.", doneAction: { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        })
    }
    
    @objc private func completeCreating() {
        startLoader()
        
        viewModel.addNewEvent { [weak self] (status, message) in
            switch status {
            case .ok:
                self?.stopLoader(withStatus: .success, andText: "Событие создано", completion: {
                    self?.dismiss(animated: true, completion: nil)
                })
            case .error:
                self?.stopLoader(withStatus: .fail, andText: message, completion: nil)
            case .fail:
                self?.stopLoader()
            }
        }
    }
}

extension AddEventViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch viewModel.sections[section] {
        case .tags:
            
            let header = UIView()
            let title = UILabel(frame: CGRect(x: 20, y: 20, width: 100, height: 15))
            title.textColor = .darkGray
            title.font = UIFont(name: "Roboto-Regular", size: 13)
            title.text = "Тэги"
            header.addSubview(title)
            return header
            
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch viewModel.sections[section] {
        case .tags:
            return 40
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = Color.lightGray
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.sections[section] {
        case .tags:
            return 2
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.sections[indexPath.section] {
        case .mainInfo:
            let cell: AddEventMainInfoTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(data: viewModel.eventData, presenterDelegate: self, actionSheetPresenterDelegate: self)
            cell.selectionStyle = .none
            return cell
        case .date:
            let cell: AddEventDateTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(data: viewModel.eventData)
            cell.selectionStyle = .none
            return cell
        case .time:
            let cell: AddEventTimeTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(data: viewModel.eventData)
            cell.selectionStyle = .none
            return cell
        case .price:
            let cell: AddEventPriceTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(data: viewModel.eventData)
            cell.selectionStyle = .none
            return cell
        case .tags:
            switch indexPath.row {
            case 0:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "EventMainTagsCell", for: indexPath)
                cell.textLabel?.text = "Основной тип события*"
                cell.detailTextLabel?.text = "(для отобрадения на шапке)"
                cell.detailTextLabel?.textColor = .lightGray
                return cell
                
            default:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "EventOtherTagsCell", for: indexPath)
                cell.textLabel?.text = "Дополнительный тип события"
                cell.detailTextLabel?.textColor = .lightGray
                return cell
                
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel.sections[indexPath.section] == .tags else { return }
        
        switch indexPath.row {
        case 0:
            let vc = Storyboard.addEventTagsViewController() as! AddEventTagsViewController
            vc.viewModel = EventTagsViewModel(tagSelectionType: .single, eventData: viewModel.eventData)
            navigationController?.pushViewController(vc, animated: true)
        default:
            let vc = Storyboard.addEventTagsViewController() as! AddEventTagsViewController
            vc.viewModel = EventTagsViewModel(tagSelectionType: .multi, eventData: viewModel.eventData)
            navigationController?.pushViewController(vc, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension AddEventViewController: ControllerPresenterDelegate, ActionSheetPresenterDelegate {
    func present(with titles: [String], actions: [VoidBlock?], styles: [UIAlertAction.Style]) {
        self.addActionSheet(titles: titles, actions: actions, styles: styles)
    }
    
    func present(controller: UIViewController, presntationType: PresentationType, completion: VoidBlock?) {
        switch presntationType {
        case .push:
            navigationController?.pushViewController(controller, animated: true)
        case .present:
            present(controller, animated: true, completion: nil)
        }
    }
}
