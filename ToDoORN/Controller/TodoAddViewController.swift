//
//  TodoAddViewController.swift
//  ToDoORN
//
//  Created by 酒匂竜也 on 2022/05/25.
//

import UIKit
import RealmSwift

class TodoAddViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var TodoaddTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var done: UIButton!
    
    
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.timeZone = TimeZone.current
        datePicker.locale = Locale.current
        TodoaddTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        TodoaddTextField.resignFirstResponder()
        
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if TodoaddTextField.text?.count ?? 0 > 0 {
            
            
            done.isEnabled = true
        }else{
            
            done.isEnabled = false
            
        }
    }
    
    @IBAction func doneButton(_ sender: Any) {
        InfoHelper().save(title:TodoaddTextField.text!,date:datePicker.date)
        
        self.navigationController?.popViewController(animated: true)
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
