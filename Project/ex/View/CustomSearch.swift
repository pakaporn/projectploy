//
//  CustomSearch.swift
//  Project
//
//  Created by Pakaporn on 10/19/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit

extension UISearchBar {
    
    func didPresentSearchController(searchController: UISearchController) {
        searchController.searchBar.showsCancelButton = false
    }
    
    public func setSerchTextcolor(color: UIColor) {
        let clrChange = subviews.flatMap { $0.subviews }
        guard let sc = (clrChange.filter { $0 is UITextField }).first as? UITextField else { return }
        sc.textColor = color
    }
}

extension PatientsTableViewController {
    
    func createSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        
        let searchBarCursor = searchController.searchBar.subviews[0]
        searchBarCursor.tintColor = .darkGray
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.searchController = searchController
        }
        else {
            tableView.tableHeaderView = searchController.searchBar
        }
        
    }
}

