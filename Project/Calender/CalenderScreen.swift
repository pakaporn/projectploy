//
//  CalenderScreen.swift
//  Project
//
//  Created by Pakaporn on 5/15/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
///

import UIKit

enum MyTheme {
    case light
    case dark
}

class CalenderScreen: UIViewController {
    
    var theme = MyTheme.dark
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Calender"
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = Style.bgColor
        
        view.addSubview(calenderView)
        calenderView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        calenderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        calenderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        calenderView.heightAnchor.constraint(equalToConstant: 365).isActive = true
        
        let rightBarBtn = UIBarButtonItem(title: "Light", style: .plain, target: self, action: #selector(rightBarBtnAction))
        self.navigationItem.rightBarButtonItem = rightBarBtn
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons25"), style: UIBarButtonItemStyle.plain, target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.revealViewController().rearViewRevealWidth = 240
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        self.navigationController?.hidesBarsOnSwipe = true

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        calenderView.myCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    @objc func rightBarBtnAction(sender: UIBarButtonItem) {
        if theme == .dark {
            sender.title = "Dark"
            theme = .light
            Style.themeLight()
        } else {
            sender.title = "Light"
            theme = .dark
            Style.themeDark()
        }
        self.view.backgroundColor = Style.bgColor
        calenderView.changeTheme()
    }
    
    let calenderView: CalenderView = {
        let v = CalenderView(theme: MyTheme.dark)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "Calender"
        if segue.identifier == iden {
            let calenderScreen = segue.destination as! CalenderScreen
        }
    }
}



