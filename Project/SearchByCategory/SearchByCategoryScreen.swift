//
//  SearchByCategoryScreen.swift
//  Project
//
//  Created by Pakaporn on 9/22/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit

class SearchByCategoryScreen: BaseMenuController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet var collectionView: UICollectionView!
    
    let category = ["แกง","ผัด","ต้ม","ทอด","อบ-ตุ๋น","นึ่ง","ยำ","น้ำพริก"]
    var keepCategory = ""
    
    let categoryImages: [UIImage] = [
        UIImage(named: "แกง")!,
        UIImage(named: "ผัด")!,
        UIImage(named: "ต้ม")!,
        UIImage(named: "ทอด")!,
        UIImage(named: "อบตุ๋น")!,
        UIImage(named: "นึ่ง")!,
        UIImage(named: "ยำ")!,
        UIImage(named: "น้ำพริก")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        var layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.collectionView.frame.size.width - 20)/2, height: self.collectionView.frame.size.height/3)
        //self.navigationController?.hidesBarsOnSwipe = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCollectionCell
        cell.categoryLabel.text = category[indexPath.item]
        cell.categoryImageView.image = categoryImages[indexPath.item]
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.cornerRadius = cell.bounds.height/8
        cell.layer.borderWidth = 0.5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.gray.cgColor
        cell?.layer.borderWidth = 2
        keepCategory = category[indexPath.row]
        print(keepCategory)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.lightGray.cgColor
        cell?.layer.borderWidth = 0.5
    }
    
//    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
//        keepCategory = "category[indexPath.item]"
//        print(keepCategory)
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let iden = "SearchByCategory"
//        if segue.identifier == iden {
//            //let logOutScreen = segue.destination as! SearchByCategoryScreen
//            let searchByCategory = segue.destination as! SearchByCategory
//            searchByCategory.keepTaskNamee = keepCategory
//            print(keepCategory)
//        }
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "SearchByCategory"
        if segue.identifier == iden {
            let searchByCategory = segue.destination as! SearchByCategory
            searchByCategory.keepTaskNamee = keepCategory
        }
    }
}


