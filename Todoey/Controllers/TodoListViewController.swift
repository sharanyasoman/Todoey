//
//  ViewController.swift
//  Todoey
//
//  Created by Sharanya Soman on 30/08/19.
//  Copyright © 2019 Sharanya Soman. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController{

    var todoItems: Results<Item>?
    
    let realm = try! Realm()
    
    var selectedCategory : Category?{
        didSet{
           loadItems()
        }
    }
    
//    UserDefaults
//    let defaults = UserDefaults.standard
    
    //Core Data
   // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UserDefaults
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
//            itemArray = items
//        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    // MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        }else{
            cell.textLabel?.text = "No items added"
        }
        return cell
    }
    
    // MARK: -  Tableview Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //    todoItems[indexPath.row].done = !todoItems[indexPath.row].done
    //    saveItems()
       // tableView.deselectRow(at: indexPath, animated: true)
        if let item = todoItems?[indexPath.row]{
            do{
                try realm.write {
                    item.done = !item.done
                }
            }catch{
                    print("Error changing the done status: \(error)")
            }
        }
        tableView.reloadData()
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()

        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            do{
            try self.realm.write {
                if let currentCategory = self.selectedCategory{
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                }
            }
            }catch{
                print("Error while writing to realm: \(error)")
            }
            
            self.tableView.reloadData()
            
            //UserDefaults
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)

        present(alert, animated: true, completion: nil)

    }

    func loadItems(){
        //parentcategory is in the relationship
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
}
// MARK: - Search Bar methods

extension TodoListViewController: UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.sorted(byKeyPath: "dateCreated", ascending: true).filter("title CONTAINS[cd] %@", searchBar.text!)
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
