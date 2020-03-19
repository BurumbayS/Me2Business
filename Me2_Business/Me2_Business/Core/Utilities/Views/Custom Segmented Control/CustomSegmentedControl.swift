//
//  CustomSegmentedControl.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 2/29/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import Cartography

class CustomSegmentedControl : UIView {
    
    var titles = [String]()
    var labels = [UILabel]()
    var segments = [UIView]()
    let flag = UIView()
    var flagConstraints = ConstraintGroup()
    
    var currentSegment = 0
    var segmentsCount = 0
    var segmentWidth: CGFloat = 0
    var segmentHeight: CGFloat = 0
    
    var viewModel: CustomSegmentedControlViewModel!
    
    func setUp(with titles : [String], with frame : CGSize) {
        self.titles = titles
        segmentsCount = titles.count
        
        segmentWidth = frame.width / CGFloat(segmentsCount)
        segmentHeight = frame.height
        
        segments.forEach { $0.removeFromSuperview() }
        labels.forEach { $0.removeFromSuperview() }
        
        segments = []
        labels = []
        
        addSegments()
        addFlag()
    }
    
    func configure(with viewModel: CustomSegmentedControlViewModel) {
        self.viewModel = viewModel
    }

    func addSegments() {
        var x : CGFloat = 0.0
        let y : CGFloat = 0.0
        for i in 0...segmentsCount - 1 {
            let segment = UIView(frame: CGRect(x: x, y: y, width: segmentWidth, height: segmentHeight))
            segment.addUnderline(with: .lightGray, and: CGSize(width: segmentWidth, height: segmentHeight))
            segments.append(segment)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(moveToSegment(_:)))
            tap.accessibilityLabel = "\(i)"
            segment.addGestureRecognizer(tap)
            
            let label = UILabel()
            label.text = titles[i]
            label.textColor = (i == 0) ? Color.red : .darkGray
            label.font = UIFont(name: "Roboto-Medium", size: 13)
            label.sizeToFit()
            label.textAlignment = .center
            labels.append(label)
            segment.addSubview(label)
            constrain(label, segment) {label, segment in
                label.centerX == segment.centerX
                label.centerY == segment.centerY
            }
            
            self.addSubview(segment)
            
            x += segmentWidth
        }
    }
    
    private func addFlag() {
        flag.removeFromSuperview()
        
        flag.layer.cornerRadius = 2
        flag.backgroundColor = Color.red
        
        self.addSubview(flag)
        let width = labels[0].text?.getWidth(with: UIFont(name: "Roboto-Medium", size: 13)!)
        constrain(flag, labels[0], self, replace: flagConstraints) { flag, label, view in
            flag.centerX == label.centerX
            flag.bottom == view.bottom
            flag.height == 3
            flag.width == (width ?? 0.0) + 20
        }
    }
    
    @objc func moveToSegment(_ sender : UITapGestureRecognizer) {
        let index = Int(sender.accessibilityLabel!)
        
        let width = self.labels[index!].text?.getWidth(with: UIFont(name: "Roboto-Medium", size: 13)!)
        constrain(self.flag, self.labels[index!], self, replace: self.flagConstraints) { flag, label, view in
            flag.centerX == label.centerX
            flag.bottom == view.bottom
            flag.height == 3
            flag.width == (width ?? 0.0) + 20
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
        
        labels[currentSegment].textColor = .darkGray
        currentSegment = index!
        labels[currentSegment].textColor = Color.red
        
        viewModel.valueChangedHandler?()
    }
    
}
