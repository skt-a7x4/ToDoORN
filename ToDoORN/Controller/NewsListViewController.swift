//
//  NewsListViewController.swift
//  ToDoORN
//
//  Created by 酒匂竜也 on 2022/05/15.
//

import UIKit

class NewsListViewController: UITableViewController,XMLParserDelegate,UITextFieldDelegate {
   
    
    

    var testText:String = "default"
    var parser:XMLParser!
    var items = [Item]()
    var item:Item?
    var currentString = ""
    var lead = [String]()
    //userDefaultsをプロパティにて宣言
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let kidoku = userDefaults.object(forKey: "kidoku") as? [String] {
            
            lead = kidoku
            
            
        }
        
        let refreshController = UIRefreshControl()
        refreshController.addTarget(self, action: #selector(startDownload), for: .valueChanged)
        self.tableView.refreshControl = refreshController
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startDownload()
        navigationController?.isNavigationBarHidden = false
    }
    
    override func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    //cellを表示する時に呼ばれる
    override func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"Cell",for: indexPath)
        if lead.contains(items[indexPath.row].link) {
            print("読んだ　\(items[indexPath.row].title)")
            cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
        }else{
            print ("読んでない　\(items[indexPath.row].title)")
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        }
    //表示する記事のタイトルを設定する
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
    
    @objc func startDownload(){
        
        print("再読み込み")
            self.items = []
            if let url = URL(
                string:"https://wired.jp/rssfeeder/"){
                if let parser = XMLParser(contentsOf: url){
                self.parser = parser
                self.parser.delegate = self
                self.parser.parse()
            }
        }
    }
    func parser(_ parser: XMLParser,didStartElement elementName: String,namespaceURI:String?,qualifiedName qName: String?,attributes attributeDict:[String:String]){
        self.currentString = ""
        if elementName == "item"{
            self.item = Item()
        }
    }
    func parser(_ parser: XMLParser,foundCharacters string : String){
        self.currentString += string
    }
    func parser(_ parser: XMLParser,didEndElement elementName: String,namespaceURI: String?,qualifiedName qName:String?){
        switch elementName {
        case "title": self.item?.title = currentString
        case "link": self.item?.link = currentString
        case "item": self.items.append(self.item!)
        default: break
        }
    }
    //XML解析終了時に呼び出しされるメソッド
    func parserDidEndDocument(_ parser: XMLParser){
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
      }
    
    //画面遷移される時に呼ばれる
    override func prepare(for segue: UIStoryboardSegue,sender:Any?){
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let item = items[indexPath.row]
            let controller = segue.destination as! NewsDetailViewController
            controller.title = item.title
            controller.link = item.link
            //既読した記事を保存するコード
            lead.append(item.link)
            //既読した記事をuserDefaultsに保存
            userDefaults.set(lead, forKey: "kidoku")
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
