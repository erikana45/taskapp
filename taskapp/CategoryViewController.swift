//
//  CategoryViewController.swift
//  taskapp
//
//  Created by 勝木えり on 2019/01/26.
//  Copyright © 2019 eri.katsuki. All rights reserved.
//


import UIKit
import RealmSwift  //追加



class CategoryViewController: UIViewController{

    @IBOutlet weak var categoryTextField: UITextField!
    
    
    
    var category: Category!
    let realm = try! Realm()
    var categoryArray = try!  Realm().objects(Category.self) //カテゴリの配列を取得
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    
  
    }
    
    
    @objc func dismissKeyboard(){
        // キーボードを閉じる
        view.endEditing(true)
    }
    
    //タスク画面に戻るときに、レルムにデータを保存
    override func viewWillDisappear(_ animated: Bool) {
       if self.categoryTextField.text != ""{

        try! realm.write {
            self.category.categorydata = self.categoryTextField.text!
            self.realm.add(self.category, update: true)
        }
        
        print("-----")
        print(category.categorydata)
        }
        
        super.viewWillDisappear(animated)
    }
    
    
    
    
    
}
