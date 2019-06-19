//
//  ViewController.swift
//  Todoey
//
//  Created by Dovydas Jakstas on 19/06/2019.
//  Copyright © 2019 Dovydas Jakstas. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Task1", "Task2", "Task3"]
    
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
    
    // MARK - Add new items method
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add your item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //What will happen when you click add item
            print("success!")
            print(textField.text!)
            self.itemArray.append(textField.text!)
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add your item"
            textField = alertTextField
            
        }
        
        //Popup addaction
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
}

