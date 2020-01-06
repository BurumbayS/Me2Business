//
//  ChatTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/6/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var liveTitleLabel: UILabel!
    @IBOutlet weak var simpleChatContextView: UIView!
    @IBOutlet weak var liveChatContextView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var simpleChatNameLabel: UILabel!
    @IBOutlet weak var simpleChatLastMessage: UILabel!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var liveChatLastMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with roomInfo: Room) {
        switch roomInfo.type {
        case .SIMPLE:
            
            simpleChatNameLabel.text = roomInfo.name
            simpleChatLastMessage.text = getLastMessageString(from: roomInfo.lastMessage)
            
            simpleChatContextView.isHidden = false
            liveChatContextView.isHidden = true
            
        case .LIVE:
            
            placeNameLabel.text = roomInfo.name
            
            if let lastMessageSender = roomInfo.getLastMessageSender() {
                let lastMessage = getLastMessageString(from: roomInfo.lastMessage)
                liveChatLastMessage.text = "\(lastMessageSender.username): \(lastMessage)"
            }
            
            simpleChatContextView.isHidden = true
            liveChatContextView.isHidden = false
            
        default:
            break
        }
        
//        avatarImageView.kf.setImage(with: URL(string: roomInfo.avatarURL), placeholder: UIImage(named: "placeholder_avatar"), options: [])
        timeLabel.text = roomInfo.lastMessage.getTime()
    }
    
    private func getLastMessageString(from message: Message) -> String {
//        if let place = message.place, place.id != 0 {
//            return "Заведение"
//        }
        
//        if let event = message.event, event.id != 0 {
//            return "Событие"
//        }
        
        switch message.type {
        case .TEXT:
            
            return message.text
            
        case .IMAGE:
            
            return "Фото"
            
        case .VIDEO:
            
            return "Видео"
            
        case .WAVE:
            
            return "Помахали"
            
        default:
            return ""
        }
    }
}
