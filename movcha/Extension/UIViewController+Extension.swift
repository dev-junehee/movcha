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
    func setNavigationTitle(_ title: String) {
        self.navigationItem.title = title
    }
    
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
    
    // MARK: Alert 얼럿
    func showAlert(_ title: String, message: String?) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        let warning = UIAlertAction(title: Text.Button.ok, style: .default)
        alert.addAction(warning)
        present(alert, animated: true)
    }
}
