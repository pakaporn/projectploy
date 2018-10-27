//
//  SearchByCheckList.swift
//  Project
//
//  Created by Pakaporn on 9/22/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//
import UIKit

class SearchByCheckListScreen: BaseMenuController, UITableViewDelegate, UITableViewDataSource, AddTask, CheckBox {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    let ingredientImageView: [UIImage] = [
        
        UIImage(named: "chicken")!,
        UIImage(named: "chop")!,
        UIImage(named: "fish")!,
        UIImage(named: "egg")!,
        UIImage(named: "egg")!,
        UIImage(named: "chili")!,
        UIImage(named: "lemon")!,
        UIImage(named: "lemon")!,
        UIImage(named: "lemon")!,
        UIImage(named: "cabbage")!
    ]
    
    var tasks: [Tasks] = [Tasks(name: "ไก่"),Tasks(name: "หมู"),Tasks(name: "ปลา"),Tasks(name: "ไข่ไก่"),Tasks(name: "ไข่เป็ด"),Tasks(name: "พริก"),Tasks(name: "มะนาว"),Tasks(name: "ใบกระเพรา"),Tasks(name: "ผักชี"),Tasks(name: "กะหล่ำปลี")]
    var keepTaskName: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! CheckListCell
        
        cell.taskNameLabel.text = tasks[indexPath.row].name
        cell.checkImage.image = ingredientImageView[indexPath.item]
        
        if tasks[indexPath.row].checked {
            cell.checkBoxOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxFILLED "), for: UIControlState.normal)
            keepTaskName.append(tasks[indexPath.row].name)
        } else {
            cell.checkBoxOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxOUTLINE "), for: UIControlState.normal)
        }
        
        cell.delegate = self
        cell.tasks = tasks
        cell.indexP = indexPath.row
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "SearchByCheckList"
        if segue.identifier == iden {
            let searchByCheckList = segue.destination as! SearchByCheckList
            searchByCheckList.keepTaskNamee = keepTaskName
            
        }
    }
    
    func addTask(name: String) {
        tasks.append(Tasks(name: name))
        tableView.reloadData()
    }
    
    func checkBox(state: Bool, index: Int?) {
        tasks[index!].checked = state
        tableView.reloadRows(at: [IndexPath(row: index!, section: 0)], with: UITableViewRowAnimation.none)
    }
}

class Tasks {
    var name = ""
    var checked = false
    
    convenience init (name: String) {
        self.init()
        self.name = name
    }
}

