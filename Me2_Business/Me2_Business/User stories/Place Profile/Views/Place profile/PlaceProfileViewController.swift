//
//  PlaceProfileViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 2/27/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import Cartography

class PlaceProfileViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topBarView: UIView!
    
    var lastContentOffset: CGFloat = 0
    var collectionViewCellheight: CGFloat = 0
    
    let viewModel = PlaceProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateCellHeight(_:)), name: .updateCellheight, object: nil)
        
        fetchData()
        setupTopBar()
        configureNavBar()
        configureCollectionView()
        configureCollectionCellDefaultHeight()
//        bindViewModel()
    }
    
    private func fetchData() {
        startLoader()
        
        viewModel.fetchData { [weak self] (status, message) in
            switch status {
            case .ok:
                self?.stopLoader()
                self?.topBarView.isHidden = false
                self?.collectionView.reloadData()
                self?.collectionView.alpha = 1.0
            case .error, .fail:
                self?.stopLoader(withStatus: .fail, andText: message, completion: nil)
            }
        }
    }
    
    private func configureNavBar() {
        makeNavBarTransparent()
        removeBackButton()
        
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.clipsToBounds = false
        collectionView.alpha = 0
        
        let layout = PlaceProfileCollectionLayout()
        layout.configure(with: (navigationController?.navigationBar.frame.size.height ?? 0) + UIApplication.shared.statusBarFrame.height)
        collectionView.collectionViewLayout = layout
        
        collectionView.register(PlaceDetailsCollectionViewCell.self)
        collectionView.register(PlaceProfileHeaderCollectionViewCell.self)
        collectionView.registerHeader(PlaceTabView.self)
        collectionView.registerHeader(UICollectionReusableView.self)
    }
    
    private func setupTopBar() {
        //Share button
        let shareView = UIView()
        shareView.layer.cornerRadius = 19
        shareView.backgroundColor = UIColor(red: 71/255, green: 71/255, blue: 71/255, alpha: 0.9)
        
        let shareButton = UIButton()
        shareButton.setImage(UIImage(named: "white_share_icon"), for: .normal)
        shareButton.addTarget(self, action: #selector(sharePlace), for: .touchDown)
        shareView.addSubview(shareButton)
        constrain(shareButton, shareView) { btn, view in
            btn.centerX == view.centerX
            btn.centerY == view.centerY
            btn.width == 16
            btn.height == 22
        }
        
        self.topBarView.addSubview(shareView)
        constrain(shareView, self.topBarView) { share, view in
            share.right == view.right - 17
            share.centerY == view.centerY
            share.height == 38
            share.width == 38
        }

        topBarView.isHidden = true
    }
    
    @objc private func updateCellHeight(_ notification: NSNotification) {
        if let dict = notification.userInfo as NSDictionary? {
            if let height = dict["tableViewHeight"] as? CGFloat {
                self.updateCollectionViewLayout(with: height)
            }
        }
    }
    
    @objc func sharePlace() {
//        self.addActionSheet(titles: ["Личным сообщением","Другие соц.сети"], actions: [sharePlaceInApp, sharePlaceViaSocial], styles: [.default, .default])
    }
    
    private func updateCollectionViewLayout(with cellHeight: CGFloat) {
        collectionViewCellheight = max(Constants.shared.minContentSize.height, cellHeight)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func configureCollectionCellDefaultHeight() {
        Constants.shared.minContentSize = CGSize(width: safeAreaSize().width, height: safeAreaSize().height - 39)
        collectionViewCellheight = Constants.shared.minContentSize.height
    }
    
    private func showNavBar() {
        makeNavBarVisible()
        
        navigationItem.title = viewModel.place.name

//        let rightItem = UIBarButtonItem(image: UIImage(named: "black_share_icon"), style: .plain, target: self, action: #selector(sharePlace))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharePlace))
    }
    
    private func hideNavBar() {
        makeNavBarTransparent()
        
        navigationItem.title = ""
        navigationItem.rightBarButtonItem = nil
    }

}

extension PlaceProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch indexPath.section {
        case 0:
            let header: UICollectionReusableView = collectionView.dequeueReusableView(for: indexPath, and: kind)
            return header
        default:
            let header: PlaceTabView = collectionView.dequeueReusableView(for: indexPath, and: kind)
            header.configure(with: viewModel.placeStatus.pagesTitles) { [weak self] (selectedSegment) in
                self?.viewModel.currentPage.value = selectedSegment
            }
            return header
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            
            return .init(width: self.view.frame.width, height: 0)
            
        default:
            
            return .init(width: self.view.frame.width, height: 40)
            
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:

            return .init(width: self.view.frame.width, height: 300)

        default:

            return .init(width: self.view.frame.width, height: collectionViewCellheight)

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
        
            let cell: PlaceProfileHeaderCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(place: viewModel.place, viewController: self)
            
            return cell
            
        default:
            
            let cell: PlaceDetailsCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(with: viewModel.place, currentPage: viewModel.currentPage, presenterDelegate: self, viewController: self)
            return cell
            
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        lastContentOffset = collectionView.contentOffset.y
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let layout = collectionView.collectionViewLayout as? PlaceProfileCollectionLayout else { return }
        
        if collectionView.contentOffset.y > 100 {
            topBarView.isHidden = true
        } else {
            topBarView.isHidden = false
        }
        
        if collectionView.contentOffset.y > 0 {
            layout.turnPinToVisibleBounds()
        } else {
            layout.offPinToVisibleBounds()
        }
        
        if collectionView.contentOffset.y > 300  {
            showNavBar()
        } else {
            hideNavBar()
        }
    }
}

extension PlaceProfileViewController: ControllerPresenterDelegate {
    func present(controller: UIViewController, presntationType: PresentationType, completion: VoidBlock?) {
        switch presntationType {
        case .present:
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true, completion: nil)
        case .push:
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}


