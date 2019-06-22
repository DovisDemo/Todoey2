//
//  ViewController.swift
//  Todoey
//
//  Created by Dovydas Jakstas on 19/06/2019.
//  Copyright © 2019 Dovydas Jakstas. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {


    
    //var itemArray = ["Task1", "Task2", "Task3"]
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    //This is where we initialize user default data storage
//    let defaults = UserDefaults.standard
    
//    let dataFilePath = FileManager.default.url(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        print(dataFilePath)
        
        
        //this one is storing in data model by building a class
        
//        let newItem1 = Item()
//        newItem1.title = "Find Mike"
//        itemArray.append(newItem1)
//
//        let newItem2 = Item()
//        newItem2.title = "Find Tom"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Find Dave"
//        itemArray.append(newItem3)
        
        loadItems()
        
        // this one is for storing into the user defaults plist file
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
    }

    
    // MARK - TableView Data source method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        //for using user defaylts
        //cell.textLabel?.text = itemArray[indexPath.row]
        //using a model we need to tell the object property .title
        //cell.textLabel?.text = itemArray[indexPath.row].title
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        // there is a better way
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        }   else {
//            cell.accessoryType = .none
//        }
//
        
        return cell
    }
    
    // MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        //give a check mark from tableviewcontroler properties -> Accessory where we defined ToDoItemCell
        //do check mark and uncheck mark when you click on the item with if statement
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        }   else {
//            itemArray[indexPath.row].done = false
//        }
        
        //use to reload the cells
//        tableView.reloadData()
        //TO remove the selection colour
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    // MARK - Add new items method
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add your item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in

            //What will happen when you click add item
            
            let newItem = Item()
            
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            
            
            
            
            
            //This is using user defaults
//            print("success!")
//            print(textField.text!)
            
//            self.itemArray.append(newItem)

//            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add your item"
            textField = alertTextField
            
        }
        
        //Popup addaction
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }

func saveItems() {
    let encoder = PropertyListEncoder()
    
    do {
        let data = try encoder.encode(itemArray)
        try data.write(to: dataFilePath!)
    } catch {
        print("Error \(error)")
    }
    self.tableView.reloadData()
}
    
    func loadItems() {
       if let data = try? Data(contentsOf: dataFilePath!) {
        let decoder = PropertyListDecoder()
        do {
        itemArray = try decoder.decode([Item].self, from: data)
    } catch {
            print("Error decoding \(error)")
        }
    }
    
}
}
