//
//  CalendarExtention.swift
//  ToDoORN
//
//  Created by 酒匂竜也 on 2022/05/20.
//

import UIKit
import Foundation


extension Date{
    
    func firstDayOfTheMonth() -> Date {
        
        return Calendar.current.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        
    }
    
    mutating func plusoneDay() {
        
        self = Calendar.current.date(byAdding: .day, value: 1, to: self)!
        
    }
    
    func getAllDays()-> [Date] {
        
        var day1st = Date().firstDayOfTheMonth()
        //Dateの空の配列を宣言する
        var days = [Date]()
        //配列に要素を１つ追加する
        days.append(day1st)
        
        let range = Calendar.current.range(of: .day, in: .month, for: day1st)!
        
        for _ in 0..<range.count - 1 {
            //    日付を加算して行く配列に追加する
            day1st.plusoneDay()
            days.append(day1st)
            
        }
        return days
    }
//    Dateからフォーマット通りにStringに変換する
    func DateToString(format:String) -> String {
        
        let df = DateFormatter()
        df.locale = Locale(identifier: "ja_JP")
        df.timeZone = TimeZone.current
        df.dateFormat =  format
        
        return df.string(from: self)
        
    }
}
