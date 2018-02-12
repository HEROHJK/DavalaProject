//
//  TableDelegate.swift
//  Athletics-List-iOS
//
//  Created by Mohamed Salah on 9/12/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit

protocol ListViewsDelegate {
    func didSelectItemAt(index: Int)
}

class TableDelegate: NSObject, UITableViewDelegate {
    
    //MARK:- Variables
    var listDelegate: ListViewsDelegate!
    
    init(listDelegate: ListViewsDelegate) {
        self.listDelegate = listDelegate
    }
    
    //MAKR:- Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listDelegate.didSelectItemAt(index: indexPath.row)
    }
    
}
