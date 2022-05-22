//
//  CalendarModel.swift
//  ToDoORN
//
//  Created by 酒匂竜也 on 2022/05/20.
//

import Foundation
import RealmSwift

class EventModel: Object {
    @objc dynamic var event = ""
    @objc dynamic var title = ""
    @objc dynamic var memo = ""
    @objc dynamic var date = ""
    @objc dynamic var start_time = ""
    @objc dynamic var end_time = ""

}

//func createEvent(success: @escaping () -> Void) {
//    do {
//        let realm = try Realm()
//        let eventModel = EventModel()
//        eventModel.title = titleTextField.text ?? ""
//        eventModel.memo = memoTextView.text
//        eventModel.date = stringFromDate(date: date as Date, format: "yyyy.MM.dd")
//        eventModel.start_time = startTextField.text ?? ""
//        eventModel.end_time = endTextField.text ?? ""
//
//        try realm.write {
//            realm.add(eventModel)
//            success()
//        }
//    } catch {
//        print("create todo error.")
//    }
//}
//
