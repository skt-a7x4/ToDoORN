//
//  ViewController.swift
//  ToDoORN
//
//  Created by 酒匂竜也 on 2022/05/19.
//

import UIKit
import Lottie
import SnapKit


class ViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var ScrollView: UIScrollView!
    //    アニメーションの変数と表示される言葉
    var  AnimationArray = ["1","2","3","4","5"]
    var AnimationStringArray = ["左にスワイプ!!","あなただけのToDoListで","充実した一日になるように","今日のTodoをどんどん書き込もう","さぁオリジナルのToDoListにしよう"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ScrollView.isPagingEnabled = true
        
        for i in 0...4 {
            
            let animationView = AnimationView()
            let animation = Animation.named(AnimationArray[i])
            animationView.frame = CGRect(x: CGFloat(i) * view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height)
            animationView.animation = animation
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .loop
            animationView.play()
            ScrollView.addSubview(animationView)
            
            SetScroll()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        
       
        
    }
    
    func SetScroll() {
        
        ScrollView.delegate = self
        
        
        ScrollView.contentSize = CGSize(width: view.frame.width * 5, height: ScrollView.frame.size.height)
        
        ScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()//Scroll画面全画面固定
            
        }
        for i in 0...4 {
            
            let animationLabel = UILabel(frame: CGRect(x: CGFloat(i) * view.frame.size.width, y: view.frame.size.height/3, width: ScrollView.frame.size.width, height: ScrollView.frame.size.height))
            
            animationLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
            animationLabel.textAlignment = .center
            animationLabel.text = AnimationStringArray[i]
            ScrollView.addSubview(animationLabel)
        }
    }
}
