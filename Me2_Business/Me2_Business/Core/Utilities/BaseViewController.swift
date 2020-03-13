//
//  BaseViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/4/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func present(_ viewControllerToPresent: UIViewController,
                          animated flag: Bool,
                          completion: (() -> Void)? = nil) {
        if viewControllerToPresent.modalPresentationStyle != .custom { viewControllerToPresent.modalPresentationStyle = .fullScreen }
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
}
