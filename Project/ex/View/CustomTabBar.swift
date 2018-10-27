//
//  CustomTabBar.swift
//  Project
//
//  Created by Pakaporn on 10/19/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit

class CustomTabBar: UITabBarController {
    
    override func viewWillLayoutSubviews() {
        var newTabBarFrame = tabBar.frame
        
        let newTabBarHeight: CGFloat = 50
        newTabBarFrame.size.height = newTabBarHeight
        newTabBarFrame.origin.y = self.view.frame.size.height - newTabBarHeight
        
        
        
        tabBar.frame = newTabBarFrame
        tabBar.isTranslucent = true
    }
    
}

