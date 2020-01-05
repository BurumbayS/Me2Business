//
//  MainTabsViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/5/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class MainTabsViewController: UITabBarController {
    
    private let chatTabViewController : UIViewController = {
        let vc = Storyboard.chatTabViewController()
        let image = UIImage(named: "chat_tab_icon")
        let selectedImage = UIImage(named: "selected_chat_tab_icon")
        let tabBarItem = UITabBarItem(title: "", image: image, selectedImage: selectedImage)
        tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        vc.tabBarItem = tabBarItem
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewControllers = [chatTabViewController]
        self.setViewControllers(viewControllers, animated: true)
    }
}
