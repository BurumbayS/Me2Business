//
//  Storyboard.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/5/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

enum Storyboard: String {
    case main = "Main"
    case loginPage = "Login"
    case chat = "Chat"
    case loader = "Loader"
    case userProfile = "UserProfile"
    
    private var storyboard: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
}

extension Storyboard {
    //Loader
    static var loaderViewController = {
        return loader.storyboard.instantiateViewController(withIdentifier: "LoaderViewController")
    }
    
    //Login pages
    static var loginViewController = {
        return loginPage.storyboard.instantiateViewController(withIdentifier: "LoginViewController")
    }
    static var applicationViewController = {
        return loginPage.storyboard.instantiateViewController(withIdentifier: "ApplicationViewController")
    }
    static var confirmCodeViewController = {
        return loginPage.storyboard.instantiateViewController(withIdentifier: "ConfirmCodeViewController")
    }
    
    //Main tab page
    static var mainTabsViewController = {
        return main.storyboard.instantiateViewController(withIdentifier: "MainTabsViewController")
    }
    
    //Chat tab pages
    static var chatTabViewController = {
        return chat.storyboard.instantiateViewController(withIdentifier: "ChatTabViewController")
    }
    static var chatViewController = {
        return chat.storyboard.instantiateViewController(withIdentifier: "ChatViewController")
    }
    static var editBookingViewController = {
        return chat.storyboard.instantiateViewController(withIdentifier: "EditBookingViewController")
    }
    
    //User profile pages
    static var userProfileViewController = {
        return userProfile.storyboard.instantiateViewController(withIdentifier: "UserProfileViewController")
    }
    static var complaintViewController = {
        return userProfile.storyboard.instantiateViewController(withIdentifier: "ComplaintViewController")
    }
}


