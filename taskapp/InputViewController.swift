//
//  InputViewController.swift
//  taskapp
//
//  Created by 勝木えり on 2019/01/17.
//  Copyright © 2019 eri.katsuki. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications    // 追加


class InputViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate  {

    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var categoryPicker: UIPickerView!
    

    
    
    let realm = try! Realm()
    var task: Task!

    var rightBarButton: UIBarButtonItem! //カテゴリ編集画面への遷移用
    var categoryArray = try!  Realm().objects(Category.self) //カテゴリの配列を取得
    
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print("カテゴリ= \(categoryArray)")
        return categoryArray.count
    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        titleTextField.text = task.title
        contentsTextView.text = task.contents
        datePicker.date = task.date
        
        //categoryPickerのデリゲート
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        //PickerViewの初期値
        categoryPicker.selectRow(2, inComponent: 0, animated: true)
        
        //カテゴリ編集画面への遷移
        self.navigationItem.rightBarButtonItem = rightBarButton
        rightBarButton = UIBarButtonItem(title: "カテゴリ編集", style: .plain, target: self, action: #selector(InputViewController.tappedRightBarButton))

    }
    
    

    // ボタンをタップしたときのアクション
    @objc func tappedRightBarButton() {
        let nextPage = CategoryViewController()
        self.navigationController?.pushViewController(nextPage, animated: true)
    }
    
    
    @objc func dismissKeyboard(){
        // キーボードを閉じる
        view.endEditing(true)
    }

  
    
    // 追加する
    override func viewWillDisappear(_ animated: Bool) {
        try! realm.write {
            self.task.title = self.titleTextField.text!
            self.task.contents = self.contentsTextView.text
            self.task.date = self.datePicker.date
            self.realm.add(self.task, update: true)
        }
    
    
        setNotification(task: task)   // 追加
        super.viewWillDisappear(animated)
    }
    
    
    // タスクのローカル通知を登録する --- ここから ---
    func setNotification(task: Task) {
        let content = UNMutableNotificationContent()
        // タイトルと内容を設定(中身がない場合メッセージ無しで音だけの通知になるので「(xxなし)」を表示する)
        if task.title == "" {
            content.title = "(タイトルなし)"
        } else {
            content.title = task.title
        }
        if task.contents == "" {
            content.body = "(内容なし)"
        } else {
            content.body = task.contents
        }
        content.sound = UNNotificationSound.default
        
        // ローカル通知が発動するtrigger（日付マッチ）を作成
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: task.date)
        let trigger = UNCalendarNotificationTrigger.init(dateMatching: dateComponents, repeats: false)
        
        // identifier, content, triggerからローカル通知を作成（identifierが同じだとローカル通知を上書き保存）
        let request = UNNotificationRequest.init(identifier: String(task.id), content: content, trigger: trigger)
        
        // ローカル通知を登録
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            print(error ?? "ローカル通知登録 OK")  // error が nil ならローカル通知の登録に成功したと表示します。errorが存在すればerrorを表示します。
        }
        
        // 未通知のローカル通知一覧をログ出力
        center.getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
            for request in requests {
                print("/---------------")
                print(request)
                print("---------------/")
            }
        }
     } // --- ここまで追加 ---
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
