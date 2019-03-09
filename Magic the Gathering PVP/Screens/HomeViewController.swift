//
//  HomeViewController.swift
//  Magic the Gathering PVP
//
//  Created by Bryan Rumsey on 2/4/19.
//  Copyright © 2019 Bryan Rumsey. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    @IBOutlet weak var usersName: UILabel!
    
    let userID = Auth.auth().currentUser?.uid
    var ref: DatabaseReference!
    
    var usersFullName: String = "" {
        didSet {
            usersName.text = usersFullName
        }
    }
    var firstName: String = "" {
        didSet {
            getUsersLastName()
        }
    }
    var lastName: String = "" {
        didSet {
            usersFullName = firstName + " " + lastName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        getUsersFirstName()
    }
    
    func getUsersFirstName() {
        let firstNRef = ref.child("users/\(self.userID!)/firstName")
        firstNRef.observeSingleEvent(of: .value, with: { (snapshot) in
            self.firstName = snapshot.value as! String
        })
    }
    
    func getUsersLastName() {
        let lastNRef = ref.child("users/\(self.userID!)/lastName")
        lastNRef.observeSingleEvent(of: .value, with: { (snapshot) in
            self.lastName = snapshot.value as! String
        })
    }
    
    @IBAction func logout(_ sender: Any) {
        var user = Auth.auth().currentUser
        print(user!.email!)
        do{
            try Auth.auth().signOut()
        }catch{
            print(error)
        }
        user = Auth.auth().currentUser
        if(user == nil){
            print("signed out")
        }
        performSegue(withIdentifier: "logout", sender: self)
    }
    
}
