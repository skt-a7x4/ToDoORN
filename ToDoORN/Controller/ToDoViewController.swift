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
//  セルの数を決めるメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
//  セルのセクション数を決めるメソッド
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
//    セルを構築する際に呼ばれるメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TodotableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = textArray[indexPath.row]
        cell.imageView!.image = UIImage(named: "checkImage")
        
        return cell
    }
//    セルがタップされた時に呼ばれるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        タップした時にその配列の番号の中身を取り出して、値を渡す
        let nextVC = storyboard?.instantiateViewController(identifier: "next") as! ListViewController
        nextVC.TodoList = textArray[indexPath.row]
        //                nextVC.TodoList = TodoText[indexPath.row]
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
//    セルの高さを決めるメソッド
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/6
    }
//    UITextFieldすなわちTodoTextの入力後に入力用キーボードを閉じる処理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textArray.append(TodoText.text!)
        TodoText.resignFirstResponder()
        TodoText.text = ""
        TodotableView.reloadData()
        
        return true
    }
    
    
    //セルの編集許可
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }

    //スワイプしたセルを削除　※arrayNameは変数名に変更してください
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {

            textArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }

    
    @IBAction func DoneButton(_ sender: Any) {
        
        
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
