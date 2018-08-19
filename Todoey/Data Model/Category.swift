//
//  Category.swift
//  Todoey
//
//  Created by Anthony Yan on 8/10/18.
//  Copyright © 2018 Anthony Yan. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    @objc dynamic var name : String = ""
    
    //each category has a "list" of Items
    //list is an object of the realm framework
    let items = List<Item>()
    
    
    
    
}
