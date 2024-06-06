//
//  UITextField+Extension.swift
//  movcha
//
//  Created by junehee on 6/7/24.
//

import UIKit

enum PaddingType {
    case left
    case right
}

extension UITextField {
    func addPadding(type: PaddingType, amount: CGFloat) {
        switch type {
        case .left:
            self.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: amount, height: 0.0))
            self.leftViewMode = .always
        case .right:
            self.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
            self.rightViewMode = .always
        }
    }
    
    func setPlaceholder(string: String, color: UIColor) {
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }
}
