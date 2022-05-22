//
//  CalendarViewController.swift
//  ToDoORN
//
//  Created by 酒匂竜也 on 2022/05/19.
//

import UIKit
import FSCalendar
import CalculateCalendarLogic
import RealmSwift

class CalendarViewController: UIViewController, FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance {
    
    
    
    var Item: Results<EventModel>!

    @IBOutlet weak var naviItem: UINavigationItem!
    @IBOutlet var Calendar: FSCalendar!

    @IBOutlet weak var ScheduleTableView: UITableView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
                // デリゲートの設定
                self.Calendar.dataSource = self
                self.Calendar.delegate = self
         

            }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年M月d日(E)"
        
        return formatter
        
    }()
    
    func judgeHoliday(_ date: Date) -> Bool {
        
        let tmpCalendar = Foundation.Calendar(identifier: .gregorian)
        
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        
        let holiday = CalculateCalendarLogic()
        
        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
        
    }
    
    func getDay(_ date:Date) -> (Int,Int,Int) {
        
        let tmpCalendar = Foundation.Calendar(identifier: .gregorian)
        
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        return (year,month,day)
        
        
    }
    
    func getWeekIdx(_ date:Date) -> Int{
        
        
        let tmpCalendar = Foundation.Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
        
        
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        if self.judgeHoliday(date){
            
            return UIColor.red
            
        }
        let weekday = self.getWeekIdx(date)
        if weekday == 1 {
            
            
            return UIColor.red
            
        }
        else if weekday == 7 {
            
            return UIColor.blue
            
        }
        
        return nil
        
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let selectDay = getDay(date)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年M月d日(E)"
        let date = formatter.string(from: date)
        naviItem.title = date
        UserDefaults.standard.set(naviItem.title,forKey: "date")
        let realm = try! Realm()
        let result = realm.objects(EventModel.self)
        for ev in result {
            
            if ev.date == date {
                
                print("ev:(ev.subject)")
                Item = realm.objects(EventModel.self)

                
            }
            
        }
        
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.view.layoutIfNeeded()
    }
    
    
    
        }
    
    
