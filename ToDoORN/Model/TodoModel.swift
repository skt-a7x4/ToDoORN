//
//  TodoModel.swift
//  ToDoORN
//
//  Created by ιεη«δΉ on 2022/05/25.
//

import Foundation
import RealmSwift
class TodoItem: Object {
    @objc dynamic var id = ""
    @objc dynamic var title = ""
    @objc dynamic var date = Date()
}
