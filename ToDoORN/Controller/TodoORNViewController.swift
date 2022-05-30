//
//  TodoORNViewController.swift
//  ToDoORN
//
//  Created by 酒匂竜也 on 2022/05/25.
//

import UIKit
import RealmSwift

class TodoORNViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate {
    
    let realm = try! Realm()
    var itemList:Results<TodoItem>!
    var token:NotificationToken!
    
    
    

    @IBOutlet weak var TodoTableView: UITableView!
    @IBOutlet weak var titleText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemList = realm.objects(TodoItem.self).sorted(byKeyPath: "date")
        
        token = realm.observe { notification, realm in
            self.TodoTableView.reloadData()
        }
        TodoTableView.deleteRows(at: [], with: .automatic)        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    //    セルの高さを決めるメソッド
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return view.frame.size.height/6
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") //cellはStep2で指定した文字列
        
       cell?.textLabel?.text = itemList[indexPath.row].title
        let item = itemList[indexPath.row]
        cell?.selectionStyle = .none
        cell?.detailTextLabel?.text = InfoHelper().dateToString(date: item.date)
        cell?.imageView!.image = UIImage(named: "checkImage")
        return cell!
    }
    
   
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            InfoHelper().deleteItem(item:itemList[indexPath.row], token: token)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    func deleteItem(item:TodoItem){
        try! realm.write(withoutNotifying:[token]){
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [item.id])
            realm.delete(item)
        }
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
