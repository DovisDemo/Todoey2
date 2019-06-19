//
//  ViewController.swift
//  Todoey
//
//  Created by Dovydas Jakstas on 19/06/2019.
//  Copyright © 2019 Dovydas Jakstas. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["Task1", "Task2", "Task3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    // MARK - TableView Data source method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    // MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        //give a check mark from tableviewcontroler properties -> Accessory where we defined ToDoItemCell
        //do check mark and uncheck mark when you click on the item with if statement
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        //TO remove the selection colour
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
}

