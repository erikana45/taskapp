//
//  Category.swift
//  taskapp
//
//  Created by 勝木えり on 2019/01/28.
//  Copyright © 2019 eri.katsuki. All rights reserved.
//

import RealmSwift


class Category: Object {
    //管理用ID
    @objc dynamic var id = 0
    
    //カテゴリー
    @objc dynamic var categorydata = ""
    
    /**
     id をプライマリーキーとして設定
     */
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
