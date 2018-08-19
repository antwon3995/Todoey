//
//  AppDelegate.swift
//  Todoey
//
//  Created by Anthony Yan on 7/24/18.
//  Copyright © 2018 Anthony Yan. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //where the realm database is located
        //command+shift+g to enter the file path
        //all must be done within realm browser
    print("This is it \(Realm.Configuration.defaultConfiguration.fileURL)")
        
        
        
        
        
        //realm object is like a number of persistent containers (relational databases)
        //initiation of Realm can throw an error
        do{
            let realm = try Realm()
            
            
        }
        catch{
            print("error initializing realm")
        }
        
        
        
        
        return true
    }

    
    func applicationWillTerminate(_ application: UIApplication) {
                self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    //lazy variables are only loaded and only take up memory when they are needed
    //The persistent container is where all the data is stored
        //SQLLite Database
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    //saving context is like the editing stage, a place where the data within the container can be updated or changed
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}





