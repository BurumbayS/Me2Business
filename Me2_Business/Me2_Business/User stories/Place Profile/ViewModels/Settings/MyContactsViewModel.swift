//
//  MyContactsViewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/3/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Alamofire
import SwiftyJSON

class MyContactsViewModel {
    
    var byLetterSections = [ByLetterContactsSection]()
    var contacts = [Contact]()
    var searchResults = [Contact]()
    
    var contactsListEditing = false
    var contactsToDelete = [Contact]()
    
    var searchActivated = false
    
    func getContacts(completion: ResponseBlock?) {
        let url = Network.contact + "/"
           
       Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Network.getAuthorizedHeaders()).validate()
           .responseJSON { (response) in
               switch response.result {
               case .success(let value):
                   
                   let json = JSON(value)
                   print(json)
                   
                   for item in json["data"]["results"].arrayValue {
                       if !item["blocked"].boolValue {
                           self.contacts.append(Contact(json: item))
                       }
                   }
       
                   self.groupContactsByLetters(contactsToGroup: self.contacts, completion: completion)
                   
               case .failure( _):
                   print(JSON(response.data as Any))
                   completion?(.fail, "")
               }
       }
    }
    
    private func groupContactsByLetters(contactsToGroup: [Contact], completion: ResponseBlock?) {
        var currentContacts = contactsToGroup
        currentContacts.sort(by: { $0.user2.username < $1.user2.username })
        
        var letter = ""
        var contacts = [Contact]()
        
        for contact in currentContacts {
            if letter != String(contact.user2.username.first!) {
                if letter != "" {
                    let byLetterSection = ByLetterContactsSection(letter: letter.uppercased(), contacts: contacts)
                    byLetterSections.append(byLetterSection)
                }
                
                letter = String(contact.user2.username.first!)
                contacts = []
            }
            
            contacts.append(contact)
        }
        
        completion?(.ok, "")
    }
    
    func deleteContacts(completion: ResponseBlock?) {
        let url = Network.contact + "/delete_many/"
        var contactIDs = [Int]()
        contactsToDelete.forEach({ contactIDs.append($0.id) })
        
        let params = ["contact_ids": contactIDs]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: Network.getAuthorizedHeaders()).validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    print(json)
                    
                    if json["code"].intValue == 0 {
                        for contact in self.contactsToDelete {
                            self.contacts.removeAll(where: { $0.id == contact.id })
                        }
                        
                        completion?(.ok, "")
                    } else {
                        completion?(.error, json["message"].stringValue)
                    }

                case .failure( _):
                    print(JSON(response.data as Any))
                }
        }
    }
    
    func select(cell : ContactTableViewCell, atIndexPath indexPath: IndexPath) {
        cell.select()
        
        switch cell.checked {
        case .checked:
            let contact = (searchActivated) ? searchResults[indexPath.row] : byLetterSections[indexPath.section].contacts[indexPath.row]
            contactsToDelete.append(contact)
        default:
            let contact = (searchActivated) ? searchResults[indexPath.row] : byLetterSections[indexPath.section].contacts[indexPath.row]
            contactsToDelete.removeAll(where: { contact.id == $0.id })
        }
    }
}
