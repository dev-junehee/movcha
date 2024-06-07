//
//  HomeViewController.swift
//  movcha
//
//  Created by junehee on 6/4/24.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    let mainTitle = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        configureData()
        configureBarBtn()
    }
    
    func configureHierarchy() {
        let subviews = [mainTitle]
        subviews.forEach {
            view.addSubview($0)
        }
    }
    
    func configureLayout() {
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(50)
        }
    }
    
    func configureUI() {
        mainTitle.font = .systemFont(ofSize: 40, weight: .black)
    }
    
    func configureData() {
        mainTitle.text = Text.Title.home
    }
    
    func configureBarBtn() {
        addImgBarBtn(title: nil, image: SystemImage.signUp!, target: self, action: #selector(signUpBarButtonClicked), type: .right, color: Color.Primary.pink)
    }
    
    @objc func signUpBarButtonClicked() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
}
