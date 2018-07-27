//
//  ViewController.swift
//  Todoey
//
//  Created by Anthony Yan on 7/24/18.
//  Copyright © 2018 Anthony Yan. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    //creating our own plist called Items
    //the stuff before it refers to the path to the documents folder where the original plist exists
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")


    var itemArray = [Item]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        print(dataFilePath)
        
        loadItems()
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
        
        let item = itemArray[indexPath.row]//shortcut
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = item.title

        
        //Sets the accessory type according to the done property of the item, using a ternary operator
        //Ternary operator-quick simple way of handling certain conditionals
        //value/variableName = condition(returns true or false) ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //This function is triggered when a row of the table view is pressed
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //the index path array for the table view is universal
//        print(itemArray[indexPath.row])
        
        //When the cell is pressed, it flashes gray and doesn't stay gray
        tableView.deselectRow(at: indexPath, animated: true)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        
    }
    
    
    //Add new items with add new items button
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDoey Item", message: "", preferredStyle: .alert)
        
        
        //every alert to have an action
            //an action represents a "choice" in the "drop down menu" of the alert
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once user selects the add item button on the alert
            
            //Creating a new item object and setting the title property to the text property of the text field
            let item = Item()
            item.title = textField.text!
            self.itemArray.append(item)
            
            
            
            self.saveItems()
            
            
            
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
    
    func saveItems(){
        //An encoder "encodes" item into the property list
        let encoder = PropertyListEncoder()
        
        do {
            
            //encoding the item array to be 'addable' to the plist
            //If the object to be encoded is a custom class
            //must extend Codable -> (:Codable)
            //Can only be encoded if the properties are standard datatypes
            //because all the properties must be shown within the plist and if they aren't standard, plist can't show them
            let data = try encoder.encode(self.itemArray)
            
            //adding the data variable to the plist using the url to the plist
            try data.write(to: self.dataFilePath!)
            
        }
        catch{
            print("Error encoding item array, \(error)")
        }
        
        
        //Reloads the data from the datasource, essentially recalls the two fundamental methods
        tableView.reloadData()
        
    }
    
    
    func loadItems(){
        
            
            //similar to encoding data -> transferring Swift datatypes to the plist
                //Decoding is transferring data from plist to Swift datatypes
            
            
            if let data = try? Data(contentsOf: dataFilePath!){
                let decoder = PropertyListDecoder()
                do{
                    itemArray = try decoder.decode([Item].self, from: data)
                }
                catch {
                    print("Too bad")
                }
            }
        }
    
    


}

