//
//  Task.swift
//  taskapp
//
//  Created by 勝木えり on 2019/01/18.
//  Copyright © 2019 eri.katsuki. All rights reserved.
//

import RealmSwift

class Task: Object {
    // 管理用 ID。プライマリーキー
    @objc dynamic var id = 0
    
    // タイトル
    @objc dynamic var title = ""
    
    // 内容
    @objc dynamic var contents = ""
    
    /// 日時
    @objc dynamic var date = Date()
    
    //カテゴリ
    @objc dynamic var category:Category! = Category()
    
   //カテゴリ番号
    @objc dynamic var categoryrow = 0
    
    /**
     id をプライマリーキーとして設定
     */
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
