//
//  PlaceTabView.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 2/29/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import Cartography

class PlaceTabView: UICollectionReusableView {
    
    let segmentedControl = CustomSegmentedControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.clipsToBounds = true
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with segments: [String], segmentChangeHadler: @escaping ((Int) -> ())) {
        segmentedControl.setUp(with: segments, with: CGSize(width: UIScreen.main.bounds.width, height: 40))
        
        let viewModel = CustomSegmentedControlViewModel { [weak self] in
            segmentChangeHadler(self?.segmentedControl.currentSegment ?? 0)
        }
        segmentedControl.configure(with: viewModel)
    }
    
    private func setUpViews() {
        segmentedControl.backgroundColor = .white
        
        self.addSubview(segmentedControl)
        constrain(segmentedControl, self) { segmentedControl, header in
            segmentedControl.top == header.top
            segmentedControl.left == header.left
            segmentedControl.right == header.right
            segmentedControl.bottom == header.bottom
            segmentedControl.height == 40
        }
    }
}
