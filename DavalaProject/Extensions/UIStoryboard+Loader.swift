//
//  UIStoryboard+Loader.swift
//  DavalaProject
//
//  Created by znfod on 2018. 3. 12..
//  Copyright © 2018년 herohjk. All rights reserved.
//

import UIKit

fileprivate enum Storyboard : String {
    case main = "Main"
    case productDeatil = "ProductDetail"
}

fileprivate extension UIStoryboard {
    
    static func loadFromProducDetail(_ identifier: String) -> UIViewController {
        
        return load(from: .main, identifier: identifier)
    }
    
    static func loadFromMain(_ identifier: String) -> UIViewController {
        return load(from: .productDeatil, identifier: identifier)
    }
    // add convenience methods for other storyboards here ...
    
    // ... or use the main loading method directly when instantiating view controller
    // from a specific storyboard
    static func load(from storyboard: Storyboard, identifier: String) -> UIViewController {
        let uiStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return uiStoryboard.instantiateViewController(withIdentifier: identifier)
    }
}

// MARK: App View Controllers

extension UIStoryboard {
    static func loadProductDetailViewController() -> ProductDetailViewController {
        return loadFromMain("ProductDetail") as! ProductDetailViewController
    }
}
