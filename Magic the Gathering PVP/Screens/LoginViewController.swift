//
//  LoginViewController.swift
//  Magic the Gathering PVP
//
//  Created by Bryan Rumsey on 2/3/19.
//  Copyright © 2019 Bryan Rumsey. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
   
    @IBOutlet weak var usernameError: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func login(_ sender: Any) {
        let error1 = "There is no user record corresponding to this identifier. The user may have been deleted."
        let error2 = "The email address is badly formatted."
        let error3 = "The password is invalid or the user does not have a password."
        if(password.text?.count ?? 0 < 8){
            usernameError.text = ""
            passwordError.text = "Sorry, the password must be at least 8 characters!"
        } else {
            Auth.auth().signIn(withEmail: username.text!, password: password.text!) { (user, error) in
                if (error1 == error?.localizedDescription) {
                    self.usernameError.text = "Sorry, that account doesn't exist!"
                    self.passwordError.text = ""
                    return
                }else if(error2 == error?.localizedDescription || (self.username.text?.isEmpty)!) {
                    self.usernameError.text = "Sorry, you must enter an email!"
                    self.passwordError.text = ""
                    return
                }else if(error3 == error?.localizedDescription){
                    self.usernameError.text = ""
                    self.passwordError.text = "Sorry, that password is incorrect!"
                } else{
                    self.performSegue(withIdentifier: "login", sender: self)
                }
            }
        }
    }
}
