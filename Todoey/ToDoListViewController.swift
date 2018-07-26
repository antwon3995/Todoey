//
//  ViewController.swift
//  Todoey
//
//  Created by Anthony Yan on 7/24/18.
//  Copyright © 2018 Anthony Yan. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let itemArray = ["Homework", "Eat", "Video Games"]
    
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

    


}

