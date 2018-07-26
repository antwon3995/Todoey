//
//  ViewController.swift
//  Todoey
//
//  Created by Anthony Yan on 7/24/18.
//  Copyright © 2018 Anthony Yan. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [""]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //Two essential methods for table views:
        //numberOfRowsInSection, and cellForRowAt indexPath
    
    //This method returns the number of items in the table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //index path is sort of like the array of entries within the table view itself, it has a row property that will return the index
    //This method makes you create a cell and return it
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //This function is triggered when a row of the table view is pressed
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //the index path array for the table view is universal
//        print(itemArray[indexPath.row])
        
        //When the cell is pressed, it flashes gray and doesn't stay gray
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        //Toggles checkmark accessory to the cell
        if (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark){
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }
        
        
    }
    
    
    //Add new items with add new items button
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDoey Item", message: "", preferredStyle: .alert)
        
        
        //every alert to have an action
            //an action represents a "choice" in the "drop down menu" of the alert
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once user selects the add item button on the alert
            
            //adding the text inside the text field to the item array
                //self. because within a closure
            self.itemArray.append(textField.text!)
            
            
            //Reloads the data from the datasource, essentially recalls the two fundamental methods
            self.tableView.reloadData()
            
        }
        
        
        
        //Adding a text field to the alert to allow the user to add items
        //alert text field is just the name we choose to be the name of the text field
        //placeholder property is just the text within the text field before the user types anything in
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        print(textField)
        
        
        alert.addAction(action)
        
        
        //"printing" the alert
        present(alert,animated: true, completion: nil)
        
    }
    


}

