//
//  ListViewController.swift
//  ToDoORN
//
//  Created by 酒匂竜也 on 2022/05/12.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var ToDoText: UILabel!
    var TodoList = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ToDoText.text = TodoList
        
        // Do any additional setup after loading the view.
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
