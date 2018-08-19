//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Anthony Yan on 7/30/18.
//  Copyright © 2018 Anthony Yan. All rights reserved.
//

import UIKit
import RealmSwift
import CoreData

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    //The category Array is an object of type Result, which means the category Array will somewhere in the code be a result of a query.
        //<Category> is just to specify the datatype the it needs to emulate
    //Result objects are also auto-updating, which means when new Category objects are created, they don't have to be manually added to the CategoryArray as they automatically are
    var categoryArray : Results<Category>?
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadCategories()

    }
    //tableview datasource methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
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






