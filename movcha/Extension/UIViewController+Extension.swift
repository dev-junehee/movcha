//
//  UIViewController+Extension.swift
//  movcha
//
//  Created by junehee on 6/4/24.
//

import UIKit

enum BarButtonType {
    case left
    case right
}

extension UIViewController {
    // BarButton - text
    func addTextBarBtn(title: String?, style: UIBarButtonItem.Style, target: Any?, action: Selector?, type: BarButtonType, color: UIColor) {
        let barButton = UIBarButtonItem(title: title, style: style, target: target, action: action)
        
        barButton.tintColor = color
        
        switch type {
        case .left:
            navigationItem.leftBarButtonItem = barButton
        case .right:
            navigationItem.rightBarButtonItem = barButton
        }
    }
    
    // BarButton - image
    func addImgBarBtn(title: String?, image: UIImage, target: AnyObject?, action: Selector?, type: BarButtonType, color: UIColor) {
        let barButton = UIBarButtonItem(title: title, image: image, target: target, action: action)
        
        barButton.tintColor = color
        
        switch type {
        case .left:
            navigationItem.leftBarButtonItem = barButton
        case .right:
            navigationItem.rightBarButtonItem = barButton
        }
    }
}
