//
//  BaseViewController.swift
//  movcha
//
//  Created by junehee on 6/26/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    // 계층
    func configureHierarchy() {
        
    }
    
    // 레이아웃
    func configureLayout() {
        
    }
    
    // 디자인 & 변하지 않는 데이터 바인딩
    func configureUI() {
        view.backgroundColor = Constants.Color.Primary.white
    }
    
}
