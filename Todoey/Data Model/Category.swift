//
//  Category.swift
//  Todoey
//
//  Created by Dovydas Jakstas on 27/06/2019.
//  Copyright © 2019 Dovydas Jakstas. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
    
}
