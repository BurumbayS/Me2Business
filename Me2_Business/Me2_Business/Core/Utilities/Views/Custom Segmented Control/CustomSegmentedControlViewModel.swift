//
//  CustomSegmentedControlViewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 2/29/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Foundation

protocol CustomSegmentedControlViewModeling {
    var valueChangedHandler: VoidBlock? { get }
}

class CustomSegmentedControlViewModel : CustomSegmentedControlViewModeling {
    var valueChangedHandler: VoidBlock?
    
    init(valueChangedHandler : @escaping VoidBlock) {
        self.valueChangedHandler = valueChangedHandler
    }
}
