//
//  Item.swift
//  Todoey
//
//  Created by Anthony Yan on 8/10/18.
//  Copyright © 2018 Anthony Yan. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object{
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var date : Date?
    
    //Linking Objects is the object corresponding with the fromType parameter
        //should only be a property of an object who a number of them, will have a relationship to the same (different)object
        //inverse of the relationship Category has with items
    //fromType: refers to the parent Object
    //property: refers to the specific property of that parent Object
        //parent Object must have a property that refers to the child object
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
    
}
