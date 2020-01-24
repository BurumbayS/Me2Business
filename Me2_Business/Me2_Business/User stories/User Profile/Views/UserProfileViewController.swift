//
//  UserProfileViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/24/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let interestsHeader = ProfileSectionHeader()
    let favouritePlacesHeader = ProfileSectionHeader()
    
    var viewModel: UserProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        configureNavBar()
        configureTableView()
//        configureViewModel()
        fetchData()
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
//        tableViewTopContraint.constant = UIApplication.shared.statusBarFrame.height
        tableView.isHidden = true
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 30
        
        tableView.registerNib(ProfileHeaderTableViewCell.self)
        tableView.register(TagsTableViewCell.self)
        tableView.register(FavouritePlacesTableViewCell.self)
        tableView.register(NoInterestsTableViewCell.self)
    }
    
    func fetchData() {
        viewModel.fetchData { [weak self] (status, message) in
            switch status {
            case .ok:
                
//                self?.byndDynamics()
                
                self?.tableView.isHidden = false
                self?.tableView.reloadData()
                
            case .error:
                break
            case .fail:
                break
            }
        }
    }
    
}

extension UserProfileViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch viewModel.sections[section] {
        case .interests:
            
            interestsHeader.configure(title: viewModel.sections[section].rawValue, type: .expand) { [weak self] in
                self?.viewModel.tagsExpanded.value = !(self?.viewModel.tagsExpanded.value)!
                self?.tableView.reloadSections([section], with: .automatic)
            }
            return interestsHeader
            
        case .favourite_places:
            
            favouritePlacesHeader.configure(title: viewModel.sections[section].rawValue, type: .seeMore) { [weak self] in
//                let vc = Storyboard.favouritePlacesViewController() as! FavouritePlacesViewController
//                vc.viewModel = FavouritePlacesViewModel(places: self?.viewModel.favouritePlaces ?? Dynamic([]), isEditable: self?.viewModel.profileType == .myProfile)
//                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return favouritePlacesHeader
            
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch viewModel.sections[section] {
        case .interests, .favourite_places:
            return 50
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch viewModel.sections[section] {
        case .favourite_places:
            return 30
        default:
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cell(for: indexPath)
    }
    
    private func cell(for indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.sections[indexPath.section]
        
        switch section {
        case .bio:
            
            let cell: ProfileHeaderTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.selectionStyle = .none
            cell.configure(user: viewModel.userInfo.value, viewController: self)
            return cell
                        
        case .interests:

            if viewModel.userInfo.value.interests.count > 0 {

                let cell: TagsTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.clipsToBounds = true
                cell.selectionStyle = .none
                cell.configure(tagsType: .normal, tagsList: TagsList(items: viewModel.userInfo.value.interests), expanded: viewModel.tagsExpanded)
                return cell

            } else {

                let cell: NoInterestsTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.clipsToBounds = true
                cell.selectionStyle = .none
                return cell

            }
            
        case .favourite_places:
            
            let cell: FavouritePlacesTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.selectionStyle = .none
            cell.configure(with: viewModel.favouritePlaces.value, onPlaceSelected: nil)
//            cell.configure(with: viewModel.favouritePlaces.value, profileType: viewModel.profileType, onPlaceSelected: { [weak self] (place) in
//                let vc = Storyboard.placeProfileViewController() as! PlaceProfileViewController
//                vc.viewModel = PlaceProfileViewModel(place: place)
//                self?.navigationController?.pushViewController(vc, animated: true)
//            }) { [weak self] in
//                let vc = Storyboard.addFavouritePlaceViewController() as! AddFavouritePlaceViewController
//                vc.viewModel = AddFavouritePlaceViewModel(favouritePlaces: (self?.viewModel.favouritePlaces.value)!, onAddPlace: { [weak self] (place) in
//                    self?.viewModel.favouritePlaces.value.append(place)
//                    self?.tableView.reloadSections([0], with: .automatic)
//                })
//                self?.navigationController?.pushViewController(vc, animated: true)
//            }
            return cell
            
        default:
            
            return UITableViewCell()

        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        viewModel.selectedCell(at: indexPath)
//
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
}

extension UserProfileViewController: ControllerPresenterDelegate {
    func present(controller: UIViewController, presntationType: PresentationType, completion: VoidBlock?) {
        switch presntationType {
        case .push:
            navigationController?.pushViewController(controller, animated: true)
        case .present:
            present(controller, animated: true, completion: nil)
        }
    }
}
