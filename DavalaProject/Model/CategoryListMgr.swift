//
//  CategoryListMgr.swift
//  CategoryList
//
//  Created by HwanYong Kim on 2018. 2. 26..
//  Copyright © 2018년 HwanYong Kim. All rights reserved.
//

import Foundation

class CategoryListMgr: NSObject {
    var allCategoryList: [CategoryListItem]
    var displayedCategoryList: [CategoryListItem]
    
    override init() {
        allCategoryList = Array()
        displayedCategoryList = Array()
    }
    
    //add category item
    func addItem(withIndex:Int, name:String, parentIndex:Int, categoryType: CategoryType) {
        let categoryListItem: CategoryListItem = CategoryListItem.init(index: withIndex, name: name, parentIndex: parentIndex, categoryType: categoryType, isSelected:  false)
        
        if categoryType == CategoryType.CATEGORY_TYPE_BIG {
            displayedCategoryList.append(categoryListItem)
        }
        
        allCategoryList.append(categoryListItem)
    }
    
    // 화면에 나타나야 할 카테고리 리스트 아이템 출력
    func getDisplayedCategoryList() -> Array<Any>{
        return displayedCategoryList
    }
    
    // 모든 카테고리 리스트 아이템 출력
    func getAllCategoryList() -> Array<Any> {
        return allCategoryList
    }
    
    // 화면에 나와야할 리스트 아이템 개수 출력
    func getNumberOfDisplayedList() -> Int {
        return displayedCategoryList.count
    }
    
    func getNumberOfAllList() -> Int {
        return allCategoryList.count
    }
    
    // displayedCategoryItem 에 최상위 항목만 남도록 리셋
    func resetDisplayedCategoryList() {
        displayedCategoryList.removeAll()
        for item in allCategoryList {
            if item.categoryType == CategoryType.CATEGORY_TYPE_BIG {
                displayedCategoryList.append(item)
            }
            item.isSelected = false
        }
    }
    
    func getItemsWithSubCategoryIndex(categoryIndex: Int) -> Array<Any> {
        var temp: Array<CategoryListItem> = Array()
        for item in allCategoryList {
            if item.parentIndex == categoryIndex {
                temp.append(item)
            }
        }
        return temp
    }
    
    
    func selectItemWithCategoryIndex(categoryIndex: Int) -> Bool {
        var subList:Array<CategoryListItem> = Array()
        for i in 0 ..< displayedCategoryList.count {
            let item: CategoryListItem = displayedCategoryList[i]
            
            if item.index == categoryIndex {
                if item.isSelected == false {
                    //하위 항목을 보여준다
                    subList = self.getItemsWithSubCategoryIndex(categoryIndex: categoryIndex) as! Array<CategoryListItem>
                    if subList != nil {
                        for j in 0 ..< subList.count {
                            let subCategoryItem:CategoryListItem = subList[j]
                            displayedCategoryList.insert(subCategoryItem, at: i+j+1)
                        }
                    }
                } else {
                    //하위 항목을 숨긴다
                    subList = self.getItemsWithSubCategoryIndex(categoryIndex: categoryIndex) as! Array<CategoryListItem>
                    if subList != nil {
                        for j in 0 ..< subList.count {
                            let subCategoryItem:CategoryListItem = subList[j]
                            if subCategoryItem.categoryType == CategoryType.CATEGORY_TYPE_SMALL {
                                if let tempIndex = displayedCategoryList.index(of: subCategoryItem) {
                                    displayedCategoryList.remove(at: tempIndex)
                                }
                            } else {
                                // child list 내부에 selected 된 child list가 존재한다
                                var grandchildList: Array<CategoryListItem> = self.getItemsWithSubCategoryIndex(categoryIndex: subCategoryItem.index) as! Array<CategoryListItem>
                                for k in 0 ..< grandchildList.count {
                                    let grandchildListItem: CategoryListItem = grandchildList[k]
                                    if subCategoryItem.isSelected == true {
                                        if let tempIndex = displayedCategoryList.index(of: grandchildListItem) {
                                            displayedCategoryList.remove(at: tempIndex)
                                        }
                                    }
                                }
                                if subCategoryItem.isSelected == true {
                                    
                                    let indexOfSubCategory: Int = displayedCategoryList.index(of: subCategoryItem)!
                                    subCategoryItem.isSelected = false
                                    displayedCategoryList[indexOfSubCategory] = subCategoryItem
                                }
                                
                                if let tempIndex = displayedCategoryList.index(of: subCategoryItem) {
                                    displayedCategoryList.remove(at: tempIndex)
                                }
                            }
                        }
                    }
                }
                item.isSelected = !item.isSelected;
                displayedCategoryList[i] = item
                return true;
            }
        }
        
        
        return false;
    }
    
}


