//
//  ToDoViewController.swift
//  ToDoORN
//
//  Created by 酒匂竜也 on 2022/05/12.
//

import UIKit

class ToDoViewController: UIViewController,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var TodoText: UITextField!
    @IBOutlet weak var TodotableView: UITableView!
    
    var textArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TodoText.delegate = self
        TodotableView.delegate = self
        TodotableView.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TodotableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = textArray[indexPath.row]
        cell.imageView!.image = UIImage(named: "checkImage")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        タップした時にその配列の番号の中身を取り出して、値を渡す
        let nextVC = storyboard?.instantiateViewController(identifier: "next") as! ListViewController
        nextVC.TodoList = textArray[indexPath.row]
        //                nextVC.TodoList = TodoText[indexPath.row]
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/6
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        TodoText.resignFirstResponder()
        TodoText.text = ""
        TodotableView.reloadData()
        
        return true
    }
    
    @IBAction func DoneButton(_ sender: Any) {
        textArray.append(TodoText.text!)
        
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
