//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Anthony Yan on 7/30/18.
//  Copyright © 2018 Anthony Yan. All rights reserved.
//

import UIKit
import RealmSwift


//swipe table view controller inherits from table view controller
    //so CategoryViewController is "grandkid" of TableViewController
class CategoryViewController: SwipeTableViewController{
    
    let realm = try! Realm()
    
    //The category Array is an object of type Result, which means the category Array will somewhere in the code be a result of a query.
        //<Category> is just to specify the datatype the it needs to emulate
    //Result objects are also auto-updating, which means when new Category objects are created, they don't have to be manually added to the CategoryArray as they automatically are
    var categoryArray : Results<Category>?
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        tableView.rowHeight = 80
        
        loadCategories()

    }
    
    
    
    //tableview datasource methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //calling super class to return a cell
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        
        //This CatgoryVC tableview datasource method, does everything the SwipeTableViewVC datasource method does (which does everything the table view VC datasource method does) except it adds more (it overrides it)
            //because the text label is changed
        
        
        
        //taking that cell and adding more "personlization" to it
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories Added"
        
        return cell
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //nil coalescing operator
            //attach to an optional object, ?? ... refers to what it will be if the object? unwrapped is empty
        return categoryArray?.count ?? 1
    }
    
    //data manipulation save and load data
    
    func saveCategories(category: Category){
        
        do{
            
            //realm.write is simply a block of code that is executed
            
            try realm.write {
                //realm.add adds an object
                realm.add(category)
            
            }
        }
        catch {
            print(error)
        }
        
        tableView.reloadData()
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToItems"{
            
            let destinationVC = segue.destination as! ToDoListViewController
            
            if let indexPath = tableView.indexPathForSelectedRow{
                //row refers to the row selected of the pre-defined index path
                destinationVC.selectedCategory = categoryArray?[indexPath.row]
            }
            
        }
    }
    
    func loadCategories(){
        
        //realm.objects(dataType.self) grabs all the objects of the specified datatype within the realm object.
        categoryArray = realm.objects(Category.self)
        
        
        
        
        
        
        
        
//        
//        do{
//            try categoryArray = context.fetch(request)
//        }
//        catch {
//            print(error)
//        }
        
        tableView.reloadData()
        
    }
    
    //Deletion of the category happens within the swipetableVC delegate method (within the superclass)
        //There is a method within the super class called updateModel that is called by the delegate method
        //that method, when called within the superclass will do nothing
        //however since the delegate method is called in this class (super.tableVIew...)
            //this overriden func is used instead
            //the reason we need the overriden func is because the specific references to objects must be made in the specific class
            //only general similarities between all VC that will use SwipeTableVC will be included within the superclass (like WHEN the updateModel is called)
                //because any item is deleted after the delete button is pressed
    override func updateModel(at indexPath: IndexPath) {
        
        if let categoryDeleted = self.categoryArray?[indexPath.row]{
            do {
                try realm.write {
                    realm.delete(categoryDeleted)
                }
            }
            catch{
                print(error)
            }
        }
    }
    
    //add new categories addButtonPressed()
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //create a new alert with text field
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (alert) in
            
            let category = Category()
            category.name = textField.text!
            
            
            
            
            
            self.saveCategories(category: category)
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
}
