//
//  ResetPasswordViewController.swift
//  Magic the Gathering PVP
//
//  Created by Bryan Rumsey on 2/4/19.
//  Copyright © 2019 Bryan Rumsey. All rights reserved.
//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var usernameError: UILabel!
    @IBOutlet weak var resetInstructions: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func resetPassword(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: self.userName.text!) { (error) in
            
            let error1 = "The email address is badly formatted."
            let error2 = "There is no user record corresponding to this identifier. The user may have been deleted."
            let instructions = "Follow the instructions that were sent to your email to reset your password!"
            
            if((self.userName.text?.isEmpty)! || error?.localizedDescription == error1){
                self.usernameError.text = "Sorry, you need to enter your email!"
                return
            }else if(error?.localizedDescription == error2){
                self.usernameError.text = "Sorry, that account doesn't exist!"
                return
            }else{
                self.resetInstructions.text = instructions
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10), execute: {
                    self.performSegue(withIdentifier: "resetPassword", sender: self)
                })
            }
        }
    }
}
