//
//  CollectionView.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/7/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class CollectionView : UICollectionView {
    private var reloadDataCompletionBlock: (() -> Void)?
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
    
    //    override var intrinsicContentSize: CGSize {
    //        let s = self.collectionViewLayout.collectionViewContentSize
    //        return CGSize(width: max(s.width, 1), height: max(s.height,1))
    //    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        reloadDataCompletionBlock?()
        reloadDataCompletionBlock = nil
    }
    
    func reloadDataWithCompletion(completion: @escaping VoidBlock) {
        reloadDataCompletionBlock = completion
        self.reloadData()
    }
}
