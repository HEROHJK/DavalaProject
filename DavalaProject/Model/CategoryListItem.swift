//
//  CategoruListItem.swift
//  CategoryList
//
//  Created by HwanYong Kim on 2018. 2. 26..
//  Copyright © 2018년 HwanYong Kim. All rights reserved.
//

import Foundation
enum CategoryType: Int {
    case CATEGORY_TYPE_BIG = 0
    case CATEGORY_TYPE_MIDEUM = 1
    case CATEGORY_TYPE_SMALL = 2
}

class CategoryListItem: NSObject {
    var index: Int = -1 // primary key of category item
    var name: String = ""   // category name
    var parentIndex: Int = -1
    var categoryType: CategoryType
    var isSelected: Bool = false
    
    init(index indexNum:Int, name nameString: String, parentIndex parentIndexNum: Int, categoryType categoryTypeNum: CategoryType, isSelected isSelectedBool: Bool ) {
        index = indexNum
        name = nameString
        parentIndex = parentIndexNum
        categoryType = categoryTypeNum
        isSelected = isSelectedBool
    }
}


