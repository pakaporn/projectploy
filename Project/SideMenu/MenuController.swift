//
//  MenuController.swift
//  Project
//
//  Created by Pakaporn on 5/15/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
///
import UIKit
import Firebase

class MenuController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var userName: UILabel!
    
    var menuOptionsLogin = ["Search", "SearchByCategory", "SearchByCheckList", "MenuPopular", "InsertMenu", "MenuFavourite", "Calendar", "BuyIngredient", "LogOut"]
    var menuOptionsNotLogin = ["Search", "SearchByCategory", "SearchByCheckList", "Login"]
    let userRef = Database.database().reference().child("users")
    
    let optionsImageViewLogin: [UIImage] = [
        UIImage(named: "search")!,
        UIImage(named: "searchcategory")!,
        UIImage(named: "searchchecklist")!,
        UIImage(named: "menuPopular")!,
        UIImage(named: "insert")!,
        UIImage(named: "menufavourite")!,
        UIImage(named: "calender")!,
        UIImage(named: "buy")!,
        UIImage(named: "logout")!
    ]
    
    let optionsImageViewNotLogin: [UIImage] = [
        UIImage(named: "search")!,
        UIImage(named: "searchcategory")!,
        UIImage(named: "searchchecklist")!,
        UIImage(named: "logout")!
    ]
    
    var optionsImageView: [UIImage] = []
    var menuOptions: [String] = []
    //var profileImageView: UIImageView!
    
    private func checkIfUserIsSignedIn() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.menuOptions = self.menuOptionsLogin
                self.optionsImageView = self.optionsImageViewLogin
                //self.profileImageView = self.profileImage
            } else {
                self.menuOptions = self.menuOptionsNotLogin
                self.optionsImageView = self.optionsImageViewNotLogin
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        set()
        checkIfUserIsSignedIn()
        profileImage.layer.cornerRadius = profileImage.bounds.height / 2
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.borderWidth = 1.0
        profileImage.clipsToBounds = true
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MenuCell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuCell
        cell.optionName.text = menuOptions[indexPath.row]
        cell.optionImage.image = optionsImageView[indexPath.item]
        //cell.optionImage.image = UIImage(named: menuOptions[indexPath.row])
        //cell.categoryImageView.image = categoryImages[indexPath.item]
        return cell
    }
    
    func observeUser() {
        let userRef = Database.database().reference().child("users")
    }
    
    func set() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                if user?.photoURL != nil {
                    ImageService.getImage(withURL: (user!.photoURL)!  ) { image, url in
                        self.profileImage.image = image
                        //print(user?.photoURL)
                    }
                }
                self.userName.text = user?.displayName
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: menuOptions[indexPath.row], sender: self)
    }
}
