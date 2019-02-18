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
    
    
    
    var category:Category! = Category()
    let realm = try! Realm()
    var taskArray = try! Realm().objects(Task.self)
    var categoryArray = try! Realm().objects(Category.self) //カテゴリの配列を取得
    var id: Int = 0
    
    
    
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
        if self.categoryTextField!.text == "" {
            dismiss(animated: true, completion: nil)
            return
            }
        let category = Category()
        let allCategories = try! Realm().objects(Category.self)
        if allCategories.count != 0 {
            category.id = allCategories.max(ofProperty: "id")! + 1
        }else{
            category.id = 1
        }
        try! realm.write {
            category.categorydata = self.categoryTextField.text!
            self.realm.add(category, update: true)
        }
        //performSegue(withIdentifier: "backInputviewController", sender: nil)
        dismiss(animated: true, completion: nil)
    
    }
    
    
    
    
    
}
