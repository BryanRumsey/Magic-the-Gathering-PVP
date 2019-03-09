//
//  BuildLibraryViewController.swift
//  Magic the Gathering PVP
//
//  Created by Bryan Rumsey on 2/25/19.
//  Copyright © 2019 Bryan Rumsey. All rights reserved.
//

import UIKit
import Firebase

class buildLibraryViewController: UIViewController {
    
    @IBOutlet weak var cardBoxCollectionView: UICollectionView!
    @IBOutlet weak var newLibraryCollectionView: UICollectionView!
    
    @IBOutlet weak var libraryName: UILabel!
    @IBOutlet weak var createLibraryButton: UIButton!
    @IBOutlet weak var addLandsButton: UIButton!
    
    var displayArray2Count: Int = 0 {
        didSet {
            testButtons()
        }
    }
    var displayArray1Count: Int = 0
    
    var alertObserver: NSObjectProtocol?
    
    var ref: DatabaseReference!
    var postHandler1: DatabaseHandle!
    var postHandler2: DatabaseHandle!
    var userID: String = ""
    
    var displayArray1: [String] = [] {
        didSet {
            self.cardBoxCollectionView.reloadData()
        }
    }
    var displayArray2: [String] = [] {
        didSet {
            self.newLibraryCollectionView!.reloadData()

        }
    }
    
    var cardBoxCardKeys: [String] = []
    var libraryCardKeys: [String] = []
    
    var cardBoxCardNames: [String] = []
    var libraryCardNames: [String] = []
    
    var name: String = ""
    var cardCount: [String:Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardBoxCollectionView.backgroundView = UIImageView(image: UIImage(named: "background.png"))
        newLibraryCollectionView.backgroundView = UIImageView(image: UIImage(named: "background.png"))
        
        userID = (Auth.auth().currentUser?.uid)!
        ref = Database.database().reference()

        displayCardBox()
 
        cardBoxCollectionView.delegate = self
        cardBoxCollectionView.dataSource = self
        
        newLibraryCollectionView.delegate = self
        newLibraryCollectionView.dataSource = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            if self.name == ""{
                self.getLibraryName()
            }else{
                self.libraryName.text = self.name
                self.displayLibrary()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        alertObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "saveNumLands"), object: nil, queue: OperationQueue.main) { (notification) in
            let alertVC = notification.object as! alertViewController
            self.addLandsToLibrary(numLands: Int(alertVC.numForests.text!)!, landName: "Forest")
            self.addLandsToLibrary(numLands: Int(alertVC.numIslands.text!)!, landName: "Island")
            self.addLandsToLibrary(numLands: Int(alertVC.numMountains.text!)!, landName: "Mountain")
            self.addLandsToLibrary(numLands: Int(alertVC.numPlains.text!)!, landName: "Plains")
            self.addLandsToLibrary(numLands: Int(alertVC.numSwamp.text!)!, landName: "Swamp")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let observer = alertObserver{
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    func displayCardBox(){
        self.getCardBoxCardKeys()
    }
    
    func getCardBoxCardKeys(){
        let keyCBRef = ref.child("users/\(userID)/collection/Card Box/cards")
        if postHandler1 != nil {
            keyCBRef.removeObserver(withHandle: postHandler1)
        }
        postHandler1 = keyCBRef.observe(DataEventType.childAdded, with: { (snapshot) in
            self.cardBoxCardKeys.append(snapshot.key)
            self.getCardBoxCardImage(key: snapshot.key)
            self.getCardBoxCardNames(key: snapshot.key)
        })
    }
    
    func getCardBoxCardImage(key: String){
        let imgCBRef = ref.child("users/\(userID)/collection/Card Box/cards/\(key)/image")
        imgCBRef.observeSingleEvent(of: .value, with: { (snapshot) in
            self.displayArray1.append(snapshot.value as! String)
        })
        displayArray1Count += 1
    }
    
    func getCardBoxCardNames(key: String) {
        let nameLRef = ref.child("users/\(userID)/collection/Card Box/cards/\(key)/name")
        nameLRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let cardName = snapshot.value as! String
            self.cardBoxCardNames.append(cardName)
        })
    }
    
    func displayLibrary(){
        getLibraryCardKeys()
    }
    
    func getLibraryCardKeys(){
        let keyLRef = ref.child("users/\(userID)/collection/\(self.libraryName.text!)/cards")
        if postHandler2 != nil {
            keyLRef.removeObserver(withHandle: postHandler2)
        }
        postHandler2 = keyLRef.observe(DataEventType.childAdded, with: { (snapshot) in
            self.libraryCardKeys.append(snapshot.key)
            self.getLibraryCardImage(key: snapshot.key)
            self.getLibraryCardNames(key: snapshot.key)
        })
    }
    
    func getLibraryCardImage(key: String){
        let imgLRef = ref.child("users/\(userID)/collection/\(self.libraryName.text!)/cards/\(key)/image")
        imgLRef.observeSingleEvent(of: .value, with: { (snapshot) in
            self.displayArray2.append(snapshot.value as! String)
        })
        displayArray2Count += 1
    }
    
    func getLibraryCardNames(key: String) {
        let nameLRef = ref.child("users/\(userID)/collection/\(self.libraryName.text!)/cards/\(key)/name")
        nameLRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let cardName = snapshot.value as! String
            self.libraryCardNames.append(cardName)
            if self.cardCount[cardName] == nil {
                self.cardCount[cardName] = 1
            } else {
                self.cardCount[cardName]! += 1
            }
        })
    }
    
    func getLibraryName(){
        let alert = UIAlertController(title: "Please enter the name of your library", message: "You can name the library what ever you would like.  If you don't name your library you won't be able to create it.", preferredStyle: UIAlertController.Style.alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter your library name"
        }
        let action = UIAlertAction(title: "Name Library", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            self.libraryName.text = textField.text!
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.displayLibrary()
            }
        }
        action.isEnabled = false
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object:alert.textFields?[0],
                                               queue: OperationQueue.main) { (notification) -> Void in
            let textField = alert.textFields![0] as UITextField
            action.isEnabled = !textField.text!.isEmpty
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in
            self.performSegue(withIdentifier: "libraryCreated", sender: self)
        }
        alert.addAction(action)
        alert.addAction(cancel)
        self.present(alert, animated:true, completion: nil)
    }
    
    
    func moveCardToLibrary(index: Int){
        self.ref.child("users/\(self.userID)/collection").child(self.libraryName.text!).updateChildValues(["cover":"lib1"])
        let dataCBRef = ref.child("users/\(userID)/collection/Card Box/cards/\(self.cardBoxCardKeys[index])")
        dataCBRef.observeSingleEvent(of: .value, with: { (snapshot) in
            self.ref.child("users/\(self.userID)/collection/\(self.libraryName.text!)/cards/").updateChildValues([snapshot.key:snapshot.value!])
        }) { (error) in
            print(error.localizedDescription)
        }
        removeCardBoxCard(index: index)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            if self.displayArray1Count < 1 {
                self.ref.child("users/\(self.userID)/collection/Card Box/cards").setValue("empty")
            }
        }
    }
    
    func moveCardToCardBox(index: Int){
        let dataLRef = ref.child("users/\(userID)/collection/\(self.libraryName.text!)/cards/\(self.libraryCardKeys[index])")
        dataLRef.observeSingleEvent(of: .value, with: { (snapshot) in
            //add the card to the card box
            self.ref.child("users/\(self.userID)/collection/Card Box/cards/").updateChildValues([snapshot.key:snapshot.value!])
        }) { (error) in
            print(error.localizedDescription)
        }
        removeLibraryCard(index: index)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            if self.displayArray2Count < 1 {
                //remove the library from the database if its empty
                self.ref.child("users/\(self.userID)/collection/\(self.libraryName.text!)").removeValue()
            }
        }
    }
    
    func validateLibraryAddition(index: Int){
        if self.cardCount[self.cardBoxCardNames[index]] == nil || self.cardCount[self.cardBoxCardNames[index]]! < 4 {
            self.moveCardToLibrary(index: index)
        } else {
            let alert = UIAlertController(title: "Error, the card limit for \(self.cardBoxCardKeys[index]) is 4", message: "You have reached the card limit for this card.", preferredStyle: UIAlertController.Style.alert)
            let cancel = UIAlertAction(title: "Close", style: .default) { (alertAction) in }
            alert.addAction(cancel)
            self.present(alert, animated:true, completion: nil)
        }
    }
    
    func removeNonLand(index: Int){
        self.moveCardToCardBox(index: index)
    }
    
    func removeLand(index: Int){
        removeLibraryCard(index: index)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            if self.cardCount.count < 1 {
                //remove the library from the database if its empty
                self.ref.child("users/\(self.userID)/collection/\(self.libraryName.text!)").removeValue()
            }
        }
    }
    
    func removeCardBoxCard(index: Int){
        self.ref.child("users/\(self.userID)/collection/Card Box/cards/\(self.cardBoxCardKeys[index])").removeValue()
        displayArray1.remove(at: index)
        cardBoxCardKeys.remove(at: index)
        cardBoxCardNames.remove(at: index)
        displayArray1Count -= 1
    }
    
    func removeLibraryCard(index: Int) {
        self.ref.child("users/\(self.userID)/collection/\(self.libraryName.text!)/cards/\(self.libraryCardKeys[index])").removeValue()
        if cardCount[libraryCardNames[index]]! > 1 {
            self.cardCount[libraryCardNames[index]]! -= 1
        }else{
            self.cardCount[libraryCardNames[index]] = nil
        }
        displayArray2.remove(at: index)
        libraryCardKeys.remove(at: index)
        libraryCardNames.remove(at: index)
        displayArray2Count -= 1
    }
    
    func testButtons(){
        if self.displayArray2Count >= 60 {
            self.createLibraryButton.isEnabled = true
            self.createLibraryButton.isHidden = false
        }else{
            self.createLibraryButton.isEnabled = false
            self.createLibraryButton.isHidden = true
        }
        if self.displayArray2Count >= 1 {
            self.addLandsButton.isEnabled = true
            self.addLandsButton.isHidden = false
        }else{
            self.addLandsButton.isEnabled = false
            self.addLandsButton.isHidden = true
        }
    }
    
    @IBAction func cancelBuildLibrary(_ sender: Any) {
        for i in 0..<libraryCardKeys.count{
            if libraryCardNames[i] != "Forest" && libraryCardNames[i] != "Island" && libraryCardNames[i] != "Mountain" && libraryCardNames[i] != "Plains" && libraryCardNames[i] != "Swamp"{
                let dataLRef = ref.child("users/\(userID)/collection/\(self.libraryName.text!)/cards/\(self.libraryCardKeys[i])")
                dataLRef.observeSingleEvent(of: .value, with: { (snapshot) in
                    self.ref.child("users/\(self.userID)/collection/Card Box/cards/").updateChildValues([snapshot.key:snapshot.value!])
                }) { (error) in
                    print(error.localizedDescription)
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.ref.child("users/\(self.userID)/collection/\(self.libraryName.text!)").removeValue()
            self.performSegue(withIdentifier: "libraryCreated", sender: self)
        }
    }
    
    @IBAction func addLandsTapped(_ sender: Any) {
        let alertService = AlertService()
        let alertVC = alertService.alert()
        present(alertVC, animated: true)
    }
    
    func addLandsToLibrary(numLands: Int, landName: String){
        let libRef = self.ref.child("users/\(self.userID)/collection/\(self.libraryName.text!)/cards")
        let landRef = ref.child("cards/\(landName)")
        landRef.observeSingleEvent(of: .value, with: { (snapshot) in
            for _ in 0..<numLands {
                libRef.childByAutoId().setValue(snapshot.value)
            }
        })
    }
}

extension buildLibraryViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == self.cardBoxCollectionView){
            return displayArray1.count
        }else{
            return displayArray2.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == self.cardBoxCollectionView){
            let cardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardBoxCell", for: indexPath) as? CardBox
            cardCell?.cardImg.image = UIImage(named: displayArray1[indexPath.row])
            return cardCell!
        }else{
            let cardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardLibraryCell", for: indexPath) as? NewLibrary
            cardCell?.cardImg.image = UIImage(named: displayArray2[indexPath.row])
            return cardCell!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == cardBoxCollectionView){
            validateLibraryAddition(index: indexPath.row)
        }else{
            if libraryCardNames[indexPath.row] == "Forest" || libraryCardNames[indexPath.row] == "Island" ||
                libraryCardNames[indexPath.row] == "Mountain" || libraryCardNames[indexPath.row] == "Plains" || libraryCardNames[indexPath.row] == "Swamp"{
                removeLand(index: indexPath.row)
            } else {
                removeNonLand(index: indexPath.row)
            }
        }
    }
}
