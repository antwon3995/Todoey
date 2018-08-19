//
//  ViewController.swift
//  Todoey
//
//  Created by Anthony Yan on 7/24/18.
//  Copyright © 2018 Anthony Yan. All rights reserved.
//

import UIKit
import RealmSwift
import CoreData


class ToDoListViewController: UITableViewController {
    

    
    
    //context is a reference to the context property (database) of the persistent container
        //UIApplication.shared.delegate is a singleton, reference to the App delegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    var todoItems : Results<Item>?
    let realm = try! Realm()
    
    //declare a new Category object named selectedCategory
        //the didSet happens IMMEDIATELY after a value is set equal to the variable
        //In this case, a value is set within the prepare segue method within CategoryVC
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
    }
    
    //Two essential methods for table views:
        //numberOfRowsInSection, and cellForRowAt indexPath
    
    //This method returns the number of items in the table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    //index path is sort of like the array of entries within the table view itself, it has a row property that will return the index
    //This method makes you create a cell and return it
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        //optional binding
        if let item = todoItems?[indexPath.row]{
            cell.textLabel?.text = todoItems?[indexPath.row].title
            
            
            //Sets the accessory type according to the done property of the item, using a ternary operator
            //Ternary operator-quick simple way of handling certain conditionals
            //value/variableName = condition(returns true or false) ? valueIfTrue : valueIfFalse
            cell.accessoryType = (todoItems?[indexPath.row].done)! ? .checkmark : .none
        }else{
            cell.textLabel?.text = "No items added"
        }
        
        
        return cell
    }
    
    //This function is triggered when a row of the table view is pressed
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //the index path array for the table view is universal
//        print(todoItems?[indexPath.row])
        
        
        
        if let item = todoItems?[indexPath.row]{
            do{
                try realm.write {
                    //realm.delete(object) deletes the specific instance of the specified object
//                    realm.delete(item)
                    
                    //done is a dynamic property, meaning it is self-updating
                   item.done = !item.done
                }
            }
            catch{
                print(error)
            }
        }
        
        tableView.reloadData()
        
        
        
        
        //When the cell is pressed, it flashes gray and doesn't stay gray
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        //This context.delete only deletes the item from the context (staging area) however doesn't actually make changes to the database
        //context.save (withi saveItems()) does the actual database updating
        //Note: deleting the item from the context should come before deleting from the itemArray so that the indexes aren't affected
//        context.delete(itemArray[indexPath.row])
//
//        itemArray.remove(at : indexPath.row)
        
        
        
        //toggling check or uncheck
//        todoItems[indexPath.row].done = !(todoItems[indexPath.row].done)
        
        //Handy method, can use the setValue method, setValue(value, attributeName)
        //itemArray[indexPath.row].setValue("Completed", forKey: "title")
        
        
        
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
            
            
            //CHALLENGE FIX THE FOLLOWING LINE TO USE REALM
            
            //
            if let currentCategory = self.selectedCategory {
                do{
                    try self.realm.write {
                        //creating new item to be added to the selected category
                        let item = Item()
                        item.date = Date()
                        item.title = textField.text!
//
//                        let currentDate = NSDate()
//                        let dateFormat = DateFormatter()
//                        dateFormat.locale = Locale.current
//                        dateFormat.dateStyle = .short
//                        dateFormat.timeStyle = .short
//
//                        item.date = dateFormat.string(from: currentDate as Date)
//
                        print(item.date)
                        
                        //instead of setting the parentCategory property of the item, better to access the items property of the category and append an item
                            //because the items property is a List of items
                    
                        currentCategory.items.append(item)
                        
                    
                    }
                }
                catch{
                    print(error)
                }
                
            }
            
            
        self.tableView.reloadData()
            
            
            
            //ALSO SAVE THE ITEM HERE
            
            
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
        
        do {
            try context.save()
            print("Success")
            
        }
        catch{
            print("Error saving context \(error)")
        }
        
        
        //Reloads the data from the datasource, essentially recalls the two fundamental methods
        tableView.reloadData()
        
    }
    

    //(with request: .....) refers to an internal and external parameter
    //when calling the method, use loadItems(with : .....)
        //when inside the method, refer to the ...... with request (internal parameter)
        //helps with readability sometimes
    //the = Item.fetchRequest() refers to the default value if when the loadItems method is called and no parameter is given, that default value is used
//
    
    
    func loadItems(){

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        //making a new item of type NSFetchRequest in a request for context
            //datatype must be specified
        //this requests all the instances within the Item entity
//        let request : NSFetchRequest<Item> = Item.fetchRequest()


//
//        let parentPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)




        //optional binding
//
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [parentPredicate, additionalPredicate])
//        }else{
//            request.predicate = parentPredicate
//        }
//
//
//
//        do{
//            itemArray = try context.fetch(request)
//        }
//        catch{
//            print(error)
//        }

        tableView.reloadData()
    }



    
    

    


}
//
////Extension for TodolistVC, search bar delegate methods
//    //note extensions are outside the last closing brace
//
extension ToDoListViewController : UISearchBarDelegate{
    
    //delegate method that activates itself each time the text within the search bar changes
        //so each time the user types something and then deletes all of it, the original list shows

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            //threads represent different paths of loading/operating
                //first thread/main is normally for UI
                //background thread is normally for the backend, API, database
            //delegate method normally run in the background thread
            //This method specifcally transfers the code to the main thread, this is done normally when the code inside is updating UI, we don't want the UI changes to be delayed by any backend stuff like what is happening in this backend delegate method 
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()//signifies that the search bar is no longer the element on the view that is selected (keyboard goes away)
            }


        }


    }


    
    //delegate method that activates itself each time the search button is pressed
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        //Recall todoItems is a Result object (array of items)
        //A Result object can call the filter method that takes in various parameters
            //can be an NSPredicate, or property + value,
        //filter method will return a Results object based off of that request
        //.sorted is another method that a Results object can use
        
        
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "date").sorted(byKeyPath: "date", ascending: true)
        tableView.reloadData()
        
        
        
        
        
        
        
        //THE FOLLOWING USES PREDICATES AND FETCHREQUESTS FROM CORE DATA
//
//
//        //when ever you want to get data from the database, you have to make NSFetchRequests
//            //querying data
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        //we need an NSPredicate to be able to query
//            //we can use language like CONTAINS, IN, BETWEEN  (from SQL) using predicates
//        //NSPredicate(format: attributeName CONTAINS 'character', args: whateverTextForm)
//            //CONTAINS is from SQL
//            //%@ represents what you are searching for, will be replaced by the argument
//            //putting [cd] in behind a command represents NOT case or diacritic sensitive
//                //meaning case or the accents/markings above letters do not matter
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        //the request has an optional predicate property that can be set to equal a predicate
//        request.predicate = predicate
//
//        //Not involving predicates, we add a sorting device
//            //sorts the results alphabetically (acsending = true) by title
//        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
//
//        //sortDescriptors<--plural
//            //expects an array of sortDescriptors, however in our case we only have one
//        request.sortDescriptors = [sortDescriptor]
//
//
//        //to get the data, we still use the fetch method, just in this case we have special sortDescriptor and predicate properties to further control the fetch
//        loadItems(with: request, predicate: predicate)
//



    }
}

