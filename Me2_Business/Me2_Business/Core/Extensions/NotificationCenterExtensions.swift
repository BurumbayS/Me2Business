//
//  NotificationCenterExtensions.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 2/29/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let makeTableViewScrollable = Notification.Name("makeTableViewScrollable")
    static let makeCollectionViewScrollable = Notification.Name("makeCollectionViewScrollable")
    static let updateCellheight = Notification.Name("updateCellheight")
    static let updateReviews = Notification.Name("updateReviews")
    static let openChatOnPush = Notification.Name("openChatOnPush")
}
