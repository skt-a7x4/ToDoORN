//
//  EventViewController.swift
//  ToDoORN
//
//  Created by 酒匂竜也 on 2022/05/22.
//

import UIKit
import EventKit

class EventViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
   
    

    
    
    @IBOutlet weak var EventTableView: UITableView!
    
    var eventStore = EKEventStore()
       let calendar = Calendar.current
       var eventArray: [EKEvent] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        EventTableView.dataSource = self
                checkAuth()
                getEventsInOneYear()
        EventTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func checkAuth() {
            //現在のアクセス権限の状態を取得
            let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
            
            if status == .authorized { // もし権限がすでにあったら
                print("アクセスできます！！")
            }else if status == .notDetermined {
                // アクセス権限のアラートを送る。
                eventStore.requestAccess(to: EKEntityType.event) { (granted, error) in
                    if granted { // 許可されたら
                        print("アクセス可能になりました。")
                    }else { // 拒否されたら
                        print("アクセスが拒否されました。")
                    }
                }
            }
        }
        
        func getEventsInOneYear() {
            
            var componentsOneYearDelay = DateComponents()
            componentsOneYearDelay.year = 1 // 今の時刻から1年進めるので1を代入
            let startDate = Date()
            let endDate = calendar.date(byAdding: componentsOneYearDelay, to: Date())! // 一年後の日付が`Date`型で簡単に作成できた。　Date()は現在の日付を表す。
            let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
            eventArray = eventStore.events(matching: predicate)
            
            EventTableView.reloadData()
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 800
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EventTableView.dequeueReusableCell(withIdentifier: "Cell") as! EventCalendarTableViewCell
                cell.event = eventArray[indexPath.row]
        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
