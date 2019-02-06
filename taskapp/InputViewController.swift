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
    @IBOutlet weak var barButtonItem: UIBarButtonItem!
    @IBOutlet weak var categoryTextField: UITextField!
    
    
    
    let realm = try! Realm()
    var task: Task!
    var category = Category()
    var categoryArray = try!  Realm().objects(Category.self) //カテゴリの配列を取得
    
    
    
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryArray.count
    }
    //UIPickerViewで最初に表示する内容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryArray[row].categorydata
    }
    //選択された後、TextViewに内容を返す
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextField.text = categoryArray[row].categorydata
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        //インスタンス
        titleTextField.text   = task.title
        contentsTextView.text = task.contents
        datePicker.date       = task.date
        categoryTextField.inputView = categoryPicker
        
        //categoryPickerのデリゲート
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        categoryPicker.showsSelectionIndicator = true
    
        //PickerViewの初期値
        categoryPicker.selectRow(2, inComponent: 0, animated: true)
        
    }
    
    
    
    @objc func dismissKeyboard(){
        // キーボードを閉じる
        view.endEditing(true)
    }

    
    
  
    
    // 画面遷移するときにレルムに保存する
    override func viewWillDisappear(_ animated: Bool) {
        try! realm.write {
            self.task.title = self.titleTextField.text!
            self.task.contents = self.contentsTextView.text
            self.task.date = self.datePicker.date
            if categoryArray.count != 0 {
                self.task.category.id = categoryPicker.selectedRow(inComponent: 0)
            }
          self.realm.add(self.task, update: true)
          }
        setNotification(task: task)
        super.viewWillDisappear(animated)
    }
    
    
    //画面遷移してきた時の表示
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleTextField.text    = task.title
        categoryTextField.text = task.category.categorydata
        contentsTextView.text  = task.contents
        datePicker.date        = task.date
        
        categoryPicker.reloadAllComponents()
        
    }
    
    
    //CategoryViewControllerへのsegue準備
    //カテゴリに何か登録されている時は、categoryクラスのidのにプラス１をして渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let categoryViewController:CategoryViewController = segue.destination as! CategoryViewController
        //カテゴリのIDを設定
        if categoryArray.count != 0 {
            category.id = categoryArray.count + 1
        }
        categoryViewController.category.id = category.id
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
