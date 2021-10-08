//
//  Category.swift
//  ToDo
//
//  Created by F1xTeoNtTsS on 07.10.2021.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
