//
//  Item.swift
//  Todoey
//
//  Created by Anthony Yan on 7/26/18.
//  Copyright © 2018 Anthony Yan. All rights reserved.
//

import Foundation

//Adding the Codable in order to make the item encodable AND decodable, able to be added to the plist
    //custom items cannot simply be added to the plist
//Also, a class can be Codable ONLY IF all it's fields are standard datatype
class Item : Codable {
    var title : String = ""
    var done : Bool = false
    
//    init(s:String, b:Bool) {
//        title = s
//        done = b
//    }
    
    
    
    
    
    
}
