//
//  Item.swift
//  Todoey
//
//  Created by Sharanya Soman on 14/09/19.
//  Copyright © 2019 Sharanya Soman. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object{
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    //inverse relationship of each item to its parent category
    //type of the destionation of the link
    //property name of the inverse relationship
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
