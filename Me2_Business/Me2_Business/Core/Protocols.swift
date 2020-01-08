//
//  Protocols.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/8/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Foundation
import UIKit

enum PresentationType {
    case present
    case push
}

protocol ControllerPresenterDelegate {
    func present(controller: UIViewController, presntationType: PresentationType, completion: VoidBlock?)
}

protocol ActionSheetPresenterDelegate {
    func present(with titles: [String], actions: [VoidBlock?], styles: [UIAlertAction.Style])
}
