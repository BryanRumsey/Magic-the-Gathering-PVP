//
//  ViewController.swift
//  Magic the Gathering PVP
//
//  Created by Bryan Rumsey on 2/1/19.
//  Copyright © 2019 Bryan Rumsey. All rights reserved.
//

import Foundation
import Contacts
import UIKit

class ViewController: UIViewController{
    
    @IBOutlet var talbleView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let store = CNContactStore()
        let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
        
        if authorizationStatus == .notDetermined {
            store.requestAccess(for: .contacts) {[weak self] didAuthorize, error in
                if didAuthorize{
                    self?.retrieveContacts(from: store)
                }
            }
        }else if authorizationStatus == .authorized {
            retrieveContacts(from: store)
        }
    }
    
    func retrieveContacts(from store: CNContactStore){
        let containerId = store.defaultContainerIdentifier()
        let predicate = CNContact.predicateForContactsInContainer(withIdentifier: containerId)
        let keysToFetch = [CNContactGivenNameKey as CNKeyDescriptor,
                           CNContactFamilyNameKey as CNKeyDescriptor,
                           CNContactImageDataAvailableKey as CNKeyDescriptor,
                           CNContactImageDataKey as CNKeyDescriptor]
        let contacts =  try! store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch)
        print(contacts)
    }
}
