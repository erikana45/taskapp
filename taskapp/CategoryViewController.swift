//
//  CategoryViewController.swift
//  taskapp
//
//  Created by 勝木えり on 2019/01/26.
//  Copyright © 2019 eri.katsuki. All rights reserved.
//


import UIKit
import RealmSwift  //追加
import UserNotifications    // 追加


class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet var categorytableView: UITableView!
    
    
    //カテゴリの配列を定義
    let myItems:NSMutableArray=["買い物","メール・電話","仕事","勉強"]
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            categorytableView.delegate = self
            categorytableView.dataSource = self
        }
    
    
    // MARK: UITableViewDataSourceプロトコルのメソッド
    // データの数（＝セルの数）を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myItems.count
    }
    
    // 各セルの内容を返すメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 再利用可能な cell を得る
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //Cellに値を設定する
        let category = myItems[indexPath.row]
        cell.textLabel?.text = (category as AnyObject).text
        
        return cell
    }
    
    
    @IBAction func tapAdd(_ sender: Any) {
        // myItemsに追加.
        myItems.add("add Cell")
        
        // TableViewを再読み込み.
        categorytableView.reloadData()
    }
    
    
    // MARK: UITableViewDelegateプロトコルのメソッド
    
    // セルが削除が可能なことを伝えるメソッド
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)-> UITableViewCell.EditingStyle {
        return .delete
    }
    
    // Delete ボタンが押された時に呼ばれるメソッド
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 削除のとき.
        if editingStyle == UITableViewCell.EditingStyle.delete {
            print("削除")
            
            // 指定されたセルのオブジェクトをmyItemsから削除する.
            myItems.removeObject(at: indexPath.row)
            
            // TableViewを再読み込み.
            categorytableView.reloadData()
    }
}
    

}
