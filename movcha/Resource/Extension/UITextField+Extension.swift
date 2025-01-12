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
    // 텍스트필드 패딩 추가
    func addPadding(type: PaddingType, amount: CGFloat) {
        switch type {
        case .left:
            self.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: amount, height: 0.0))
            self.leftViewMode = .always
        case .right:
            self.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: amount, height: 0.0))
            self.rightViewMode = .always
        }
    }
    
    // 텍스트 필드 placeholder 추가
    func setPlaceholder(string: String, color: UIColor) {
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }
    
    /**
     길이가 8자리일때 / 8자리 아닐 때
     숫자만 있을 때 / 숫자 외
     앞 뒤 공백 자르기
     공백만 있을 때
    */
    // 텍스트 필드 유효성 검사
    func validationText() -> [Any] {
        guard let text = self.text else {
            return [false]
        }
        
        if text.isEmpty {
            return [false, "공백입니다.\n날짜를 입력해 주세요!"]
        }
        
        if Int(text) == nil {
            return [false, "8자리 숫자만 입력해 주세요!"]
        }
        
        if text.count != 8 {
            return [false, "8자리를 입력해 주세요!"]
        }
        
        return [true]
    }
}
