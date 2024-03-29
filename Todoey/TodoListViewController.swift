//
//  ViewController.swift
//  Todoey
//
//  Created by Dovydas Jakstas on 19/06/2019.
//  Copyright © 2019 Dovydas Jakstas. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class TodoListViewController: UITableViewController {


    
    //var itemArray = ["Task1", "Task2", "Task3"]

    let realm = try! Realm()
    var itemArray: Results<Item>?
    
    
//    var itemArray = [Item]()
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//    let request : NSFetchRequest<Item> = Item.fetchRequest()
    
    //This is where we initialize user default data storage
//    let defaults = UserDefaults.standard
    
//    let dataFilePath = FileManager.default.url(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        
        
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
        
        
        
        // this one is for storing into the user defaults plist file
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
        
        
    }

    
    // MARK - TableView Data source method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return itemArray.count
        return itemArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        //Mano sudai
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //Mano sudai
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        //for using user defaylts
        //cell.textLabel?.text = itemArray[indexPath.row]
        //using a model we need to tell the object property .title
        //cell.textLabel?.text = itemArray[indexPath.row].title

        if let item = itemArray?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No items added"
        }

//        let item = itemArray[indexPath.row]
//        cell.textLabel?.text = item.title
    
        
        // there is a better way
        
//        cell.accessoryType = item.done == true ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        }   else {
//            cell.accessoryType = .none
//        }
//
        
        return cell
    }
    
    // MARK - TableView Delegate Methods (this happens when user clicks on cell)
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //Realm update method
        
        //Mano nesamones
        
        
        
        if let item = itemArray?[indexPath.row] {
            do {
            try realm.write {
                // true becomes fasle, false becomes true
            item.done = !item.done
        }
            } catch {
                print("Error while status is beeing changed \(error)")
            }
        }
        
        tableView.reloadData()
        
        
        //print(itemArray[indexPath.row])
        //give a check mark from tableviewcontroler properties -> Accessory where we defined ToDoItemCell
        //do check mark and uncheck mark when you click on the item with if statement
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        
//        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
//        saveItems()
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
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                        self.realm.add(newItem)
                    }
                } catch {
                    print("Error from Realm \(error)")
                }
            }
            
            self.tableView.reloadData()
            
            
//            self.tableView.reloadData()
            
            
//            let newItem = Item(context: self.context)
            
//            newItem.title = textField.text!
//
//            newItem.done = false
//
//            newItem.parentCategory = self.selectedCategory
//
//            self.itemArray.append(newItem)
            
            
            
            
            
            
            //This is using user defaults
//            print("success!")
//            print(textField.text!)
            
//            self.itemArray.append(newItem)

//            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
//            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add your item"
            textField = alertTextField
            
        }
        
        //Popup addaction
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }

//func saveItems() {
////    let encoder = PropertyListEncoder()
//
//    do {
//        try context.save()
//
////        let data = try encoder.encode(itemArray)
////        try data.write(to: dataFilePath!)
//    } catch {
//        print("Error: \(error)")
////        print("Error \(error)")
//    }
//    self.tableView.reloadData()
//}
    
    
    func loadItems() {
        
        itemArray = selectedCategory?.items.sorted(byKeyPath: "title", ascending: false)
        
    }
    //as a default value the Item.fetchRequest() is passed if you want to use a default value when calling this function
//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {

        //code for reading to plist file
        //       if let data = try? Data(contentsOf: dataFilePath!) {
//        let decoder = PropertyListDecoder()
//        do {
//        itemArray = try decoder.decode([Item].self, from: data)
//    } catch {
//            print("Error decoding \(error)")
//        }
//    }
//     // code for reading data in CoreData model
        
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        //load only items with parent category and which are in that category
        
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)

//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//        } else {
//            request.predicate = categoryPredicate
//        }
    
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
//
//        request.predicate = compoundPredicate
        
        
//        do {
//           itemArray = try context.fetch(request)
//        } catch {
//            print("Error \(error)")
//        }
 //Realm
    func save(newItem: Item) {
        do {
            try realm.write {
                realm.add(newItem)
            }
        } catch {
            print("Error from Realm \(error)")
        }
        
        self.tableView.reloadData()
    }
        
}
//}

extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        //Realm model to query database (to filter you need to load them too. here its done with the loaditems method) 
        
        itemArray = itemArray?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: false)
        
        
        tableView.reloadData()
        
        //Core data model to query the database
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//
//        loadItems(with: request)
//
//        do {
//            itemArray = try context.fetch(request)
//        } catch {
//            print("Error \(error)")
//        }
        
        print(searchBar.text!)
        
        
        
       
        }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            //to run the command in background of removing the cursor and keyboard
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                self.tableView.reloadData()
            }
        }
    }
    
}
