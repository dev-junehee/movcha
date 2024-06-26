//
//  BaseView.swift
//  movcha
//
//  Created by junehee on 6/26/24.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 계층
    func configureHierarchy() { }
    
    // 레이아웃
    func configureLayout() { }
    
    // 디자인 & 변하지 않는 데이터 바인딩
    func configureUI() {
    }
}
