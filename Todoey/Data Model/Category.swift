//
//  Category.swift
//  Todoey
//
//  Created by Sharanya Soman on 14/09/19.
//  Copyright © 2019 Sharanya Soman. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
