//
//  Data.swift
//  Todoey
//
//  Created by Anthony Yan on 8/8/18.
//  Copyright © 2018 Anthony Yan. All rights reserved.
//

import Foundation
import RealmSwift

//Object comes form the realm framework
    //by extending the custom object to Object, we allow our custom objects to use features of Realm
class Data : Object {
    
    //dynamic in front of an initialization/declaration of a variable, allows realm to monitor changes in the variable AND based on those changes, modify the values within the database
    //@objc because dynamic is a keyword of objective c
    @objc dynamic var name : String = ""
    @objc dynamic var age : Int = 0
    
    
    
}
