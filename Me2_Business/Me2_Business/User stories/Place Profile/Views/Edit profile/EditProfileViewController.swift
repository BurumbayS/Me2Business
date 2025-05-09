//
//  EditProfileViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/3/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: EditProfileViewModel!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        bindDynamics()
        configureTableView()
    }
    
    private func configureNavBar() {
        removeBackButton()
        
        navigationItem.title = "Редактировать профиль"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelEditing))
        navigationItem.leftBarButtonItem?.tintColor = Color.red
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(completeEditing))
//        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.tintColor = Color.blue
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
        tableView.registerNib(EditMainInfoTableViewCell.self)
        tableView.register(EditDefaultInfoTableViewCell.self)
        tableView.register(EditAdditionalInfoTableViewCell.self)
    }
    
    private func bindDynamics() {
        viewModel.editedPlaceInfo.bind { (place) in
            print("Info edited")
        }
        
        viewModel.tagsData.bind { (tagsData) in
            print("Info edited")
        }
    }
    
    @objc private func cancelEditing() {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func completeEditing() {
        self.view.endEditing(true)

        startLoader()
        
        viewModel.updatePlaceInfo { [weak self] (status, message) in
            switch status {
            case .ok:
                self?.stopLoader(withStatus: .success, andText: "Данные обновлены", completion: {
                    self?.navigationController?.popViewController(animated: true)
                })
            case .error, .fail:
                self?.stopLoader(withStatus: .fail, andText: message, completion: nil)
            }
        }
    }
    
}

extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch viewModel.sections[section] {
        case .mainInfo:
            return 10
        case .additional:
            return 20
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        
        switch viewModel.sections[section] {
        case .mainInfo:
            header.backgroundColor = .white
        default:
            header.backgroundColor = .clear
        }
        
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.sections[section] {
        case .additional:
            return viewModel.additionalCells.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.sections[indexPath.section]
        
        switch section {
        case .mainInfo:
            
            let cell: EditMainInfoTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(place: viewModel.editedPlaceInfo.value, vc: self)
            cell.selectionStyle = .none
            return cell
            
        case .additional:
            
            let cell: EditAdditionalInfoTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.selectionStyle = .none
            cell.configure(title: viewModel.additionalCells[indexPath.row].title)
            return cell
            
        default:
            
            let cell: EditDefaultInfoTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(sectionType: section, data: viewModel.dataForSection(atIndex: indexPath.section), place: viewModel.editedPlaceInfo.value)
            cell.selectionStyle = .none
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel.sections[indexPath.section] == .additional else { return }
        
        switch viewModel.additionalCells[indexPath.row] {
        case .workTime:
            
            let vc = Storyboard.workTimeViewController() as! WorkTimeViewController
            vc.viewModel = EditWorlTimeViewModel(workingHours: viewModel.editedPlaceInfo.value.workingHours!)
            navigationController?.pushViewController(vc, animated: true)
            
        case .tags:
            
            viewModel.tagsData.value.averageBillPrice = 100
            let vc = Storyboard.editTagsViewController() as! EditTagsViewController
            vc.viewModel = EditTagsViewModel(data: viewModel.tagsData.value)
            navigationController?.pushViewController(vc, animated: true)
            
        case .gallery:
            
            let vc = Storyboard.editGalleryViewController() as! EditGalleryViewController
            vc.viewModel = EditGalleryViewModel(place: viewModel.editedPlaceInfo.value)
            navigationController?.pushViewController(vc, animated: true)
            
        case .menu:
            
            let vc = Storyboard.editMenuViewController() as! EditMenuViewController
            vc.viewModel = EditMenuViewModel(placeInfo: viewModel.editedPlaceInfo.value)
            navigationController?.pushViewController(vc, animated: true)

        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
