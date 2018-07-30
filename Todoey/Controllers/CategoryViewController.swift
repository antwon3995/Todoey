//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Anthony Yan on 7/30/18.
//  Copyright © 2018 Anthony Yan. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadCategories()

    }
    //tableview datasource methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let category = categoryArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    //data manipulation save and load data
    
    func saveCategories(){
        
        do{
            try context.save()
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
                destinationVC.selectedCategory = categoryArray[indexPath.row]
            }
            
        }
    }
    
    func loadCategories(with request : NSFetchRequest<Category> = Category.fetchRequest()){
        
        
        do{
            try categoryArray = context.fetch(request)
        }
        catch {
            print(error)
        }
        
        tableView.reloadData()
        
    }
    
    //add new categories addButtonPressed()
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //create a new alert with text field
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (alert) in
            
            let category = Category(context: self.context)
            category.name = textField.text
            
            self.categoryArray.append(category)
            
            
            
            self.saveCategories()
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
}






