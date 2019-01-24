//
//  CategoryViewController.swift
//  taskapp
//
//  Created by 勝木えり on 2019/01/23.
//  Copyright © 2019 eri.katsuki. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
        // MARK: UITableViewDataSourceプロトコルのメソッド
        // データの数（＝セルの数）を返すメソッド
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 0
        }
    
    
        // 各セルの内容を返すメソッド
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // 再利用可能な cell を得る
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            return cell
        }
        
        // MARK: UITableViewDelegateプロトコルのメソッド
        // 各セルを選択した時に実行されるメソッド
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        }
        
        // セルが削除が可能なことを伝えるメソッド
        func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)-> UITableViewCell.EditingStyle {
            return .delete
        }
        
        // Delete ボタンが押された時に呼ばれるメソッド
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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


