//
//  ChatRoomViewController.swift
//  Magic the Gathering PVP
//
//  Created by Bryan Rumsey on 2/27/19.
//  Copyright © 2019 Bryan Rumsey. All rights reserved.
//

import UIKit
import Firebase

class chatRoomViewController: UIViewController {
    
    @IBOutlet weak var chatName: UILabel!
    @IBOutlet weak var message: UITextField!
    
    @IBOutlet weak var chatRoomTableView: UITableView!
    
    var ref: DatabaseReference!
    var postHandler: DatabaseHandle!
    
    var handles: [String] = []
    var messages: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatRoomTableView.backgroundView = UIImageView(image: UIImage(named: "background.png"))
        
        ref = Database.database().reference()
        
        let email = (Auth.auth().currentUser?.email)!
        let emailComponents = email.components(separatedBy: "@")
        chatName.text = emailComponents[0] + ":"
        
        getData()
        
        chatRoomTableView.delegate = self
        chatRoomTableView.dataSource = self
    }
    
    func getData(){
        let postRef = ref.child("chatRoom")
        postHandler = postRef.observe(DataEventType.childAdded, with: { (snapshot) in
            self.handles.append(snapshot.key)
            self.messages.append(snapshot.value as! String)
            self.chatRoomTableView.reloadData()
            
            let indexpath = IndexPath(row: self.handles.count - 1, section: 0)
            self.chatRoomTableView.scrollToRow(at: indexpath, at: .bottom, animated: false)
            
        })
    }
    
    func getDate() -> String {
        let date = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let min = calendar.component(.minute, from: date)
        let sec = calendar.component(.second, from: date)
        
        let dateTime = "\(month):\(day) \(hour):\(min):\(sec)"
        return dateTime
    }
    
    @IBAction func postMessage(_ sender: Any) {
        let chatHandle = "\(getDate()) \(chatName.text!)"
        
        self.ref.child("chatRoom").updateChildValues([chatHandle:message.text!])
        message.text = ""
    }
    
}

extension chatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") as! chatRoomTableCell
        
        cell.setPost(handle: self.handles[indexPath.row], message: self.messages[indexPath.row])
        
        return cell
    }
}
