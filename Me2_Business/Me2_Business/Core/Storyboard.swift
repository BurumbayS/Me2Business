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
    case events = "Events"
    case placeProfile = "PlaceProfile"
    
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
    static var contactsViewController = {
        return chat.storyboard.instantiateViewController(withIdentifier: "ContactsViewController")
    }
    
    //User profile pages
    static var userProfileViewController = {
        return userProfile.storyboard.instantiateViewController(withIdentifier: "UserProfileViewController")
    }
    static var complaintViewController = {
        return userProfile.storyboard.instantiateViewController(withIdentifier: "ComplaintViewController")
    }
    
    //Events tab pages
    static var eventsTabViewController = {
        return events.storyboard.instantiateViewController(withIdentifier: "EventsTabViewController")
    }
    static var archivedEventsViewController = {
        return events.storyboard.instantiateViewController(withIdentifier: "ArchivedEventsViewController")
    }
    static var eventInfoViewController = {
        return events.storyboard.instantiateViewController(withIdentifier: "EventInfoViewController")
    }
    static var addEventViewController = {
        return events.storyboard.instantiateViewController(withIdentifier: "AddEventViewController")
    }
    static var addEventTagsViewController = {
        return events.storyboard.instantiateViewController(withIdentifier: "AddEventTagsViewController")
    }
    
    //Place profile pages
    static var placeProfileViewController = {
        return placeProfile.storyboard.instantiateViewController(withIdentifier: "PlaceProfileViewController")
    }
    static var settingsViewController = {
        return placeProfile.storyboard.instantiateViewController(withIdentifier: "SettingsViewController")
    }
    static var editProfileViewController = {
        return placeProfile.storyboard.instantiateViewController(withIdentifier: "EditProfileViewController")
    }
}


