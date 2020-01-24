//
//  FavouritePlacesTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/24/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import Cartography

class FavouritePlacesTableViewCell: UITableViewCell {
    
    var collectionView: UICollectionView!
    let placeHolderLabel = UILabel()
    
    var places = [Place]()
    
    var placeSelectionHandler: ((Place) -> ())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
        configureCollectionView()
        setCollectionViewLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with places: [Place], onPlaceSelected: ((Place) -> ())?) {
        self.places = places
        self.placeSelectionHandler = onPlaceSelected
        
        if places.count > 0 {
            collectionView.isHidden = false
        } else {
            collectionView.isHidden = true
        }
        
        collectionView.reloadData()
    }
    
    private func setUpViews() {
        placeHolderLabel.textColor = .darkGray
        placeHolderLabel.text = "Любимых мест пока нет"
        placeHolderLabel.font = UIFont(name: "Roboto-Regular", size: 15)
        self.contentView.addSubview(placeHolderLabel)
        constrain(placeHolderLabel, self.contentView) { label, view in
            label.centerX == view.centerX
            label.centerY == view.centerY
            label.height == 20
        }
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewLayout())
        collectionView.backgroundColor = .white
        collectionView.isHidden = true
        self.contentView.addSubview(collectionView)
        constrain(collectionView, self.contentView) { collection, view in
            collection.left == view.left
            collection.top == view.top
            collection.right == view.right
            collection.bottom == view.bottom
            collection.height == 90
        }
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        collectionView.register(FavouritePlaceCollectionViewCell.self)
    }
}

extension FavouritePlacesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 90)
        
        collectionView.collectionViewLayout = layout
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FavouritePlaceCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(with: places[indexPath.row].logo, and: places[indexPath.row].name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        placeSelectionHandler?(places[indexPath.row])
    }
}

