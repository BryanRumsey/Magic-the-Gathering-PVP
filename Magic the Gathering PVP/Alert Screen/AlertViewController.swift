//
//  AlertViewController.swift
//  Magic the Gathering PVP
//
//  Created by Bryan Rumsey on 3/4/19.
//  Copyright © 2019 Bryan Rumsey. All rights reserved.
//

import UIKit

class alertViewController: UIViewController {
    
    @IBOutlet weak var numForests: UITextField!
    @IBOutlet weak var numIslands: UITextField!
    @IBOutlet weak var numMountains: UITextField!
    @IBOutlet weak var numPlains: UITextField!
    @IBOutlet weak var numSwamp: UITextField!
    
    @IBOutlet weak var addLandsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [numForests, numIslands, numMountains, numPlains, numSwamp].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged)})
    }
    
    @objc func editingChanged(_ textField: UITextField){
        guard
            let numForests = numForests.text, !numForests.isEmpty, testFieldIsValid(string: numForests),
            let numIslands = numIslands.text, !numIslands.isEmpty, testFieldIsValid(string: numIslands),
            let numMountains = numMountains.text, !numMountains.isEmpty, testFieldIsValid(string: numMountains),
            let numPlains = numPlains.text, !numPlains.isEmpty, testFieldIsValid(string: numPlains),
            let numSwamp = numSwamp.text, !numSwamp.isEmpty, testFieldIsValid(string: numSwamp)
            else {
                addLandsButton.isEnabled = false
                addLandsButton.isHidden = true
                return
        }
        addLandsButton.isEnabled = true
        addLandsButton.isHidden = false
    }
    
    func testFieldIsValid(string: String) -> Bool {
        let inverseSet = NSCharacterSet(charactersIn: "0123456789").inverted
        let components = string.components(separatedBy: inverseSet)
        let filtered = components.joined(separator: "")
        return string == filtered
    }
    
    @IBAction func addLands(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("saveNumLands") ,object: self)
        dismiss(animated: true)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
}
