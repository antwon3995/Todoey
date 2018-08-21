//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Anthony Yan on 8/21/18.
//  Copyright © 2018 Anthony Yan. All rights reserved.
//

import UIKit
import SwipeCellKit

//whole purpose of this class is convenience, since it will be used twice: with both CategoryVC and ToDoListVC

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //TableVIew Datasource methods
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
       cell.delegate = self
        return cell
    }
    
    
    
    //swipe cell delegate methods
    
        func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
            
            //swiping from the right will trigger the action
            guard orientation == .right else { return nil }
            
            //creating a SwipeAction (from the SwipeCellKit framework)
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                // handle action by updating model with deletion
                //inside the closure, is the code that will run upon pressing the action
                
                
                //updates the database, deletes the items
                self.updateModel(at: indexPath)
                
          }
            
            // customize the action appearance
            deleteAction.image = UIImage(named: "delete-icon")
            
            return [deleteAction]
        }
        
        //optional method that allows more customization
        
        func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
            //Creating a new object of type SwipeOptions
            var options = SwipeOptions()
            
            //options object has different properties representing different styles
            //These options can be viewed further on the github page for the SwipeCellKit
            options.expansionStyle = .destructive
            //        options.transitionStyle = .border
            return options
        }
    
    func updateModel(at indexPath: IndexPath){
        
    }
        
}
    
    
    



