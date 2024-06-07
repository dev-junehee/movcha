//
//  SignUpViewController.swift
//  movcha
//
//  Created by junehee on 6/4/24.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    
    let titleLabel = UILabel()
    
    let emailField = UITextField()
    let passwordField = UITextField()
    let nicknameField = UITextField()
    let locationField = UITextField()
    let recommendField = UITextField()
    
    let signUpButton = UIButton()
    
    let addInfoLabel = UILabel()
    let addInfoSwitch = UISwitch()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureLayout()
        configureUI()
        configureData()
        configureBarBtn()
    }
    
    func configureHierarchy() {
        view.backgroundColor = .systemBackground
        
        let subViews: [UIView] = [titleLabel, emailField, passwordField, nicknameField, locationField, recommendField, signUpButton, addInfoLabel, addInfoSwitch]
        
        for subview in subViews {
            view.addSubview(subview)
        }
    }

    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.centerX.equalTo(view)
        }
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(80)
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 300, height: 40))
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(16)
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 300, height: 40))
        }
        
        nicknameField.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(16)
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 300, height: 40))
        }
        
        locationField.snp.makeConstraints { make in
            make.top.equalTo(nicknameField.snp.bottom).offset(16)
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 300, height: 40))
        }
        
        recommendField.snp.makeConstraints { make in
            make.top.equalTo(locationField.snp.bottom).offset(16)
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 300, height: 40))
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(recommendField.snp.bottom).offset(16)
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 300, height: 50))
        }
        
        addInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(45)
        }
        
        addInfoSwitch.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(45)
        }
    }
    
    func configureUI() {
        titleLabel.font = .systemFont(ofSize: 44, weight: .black)
        titleLabel.textColor = Color.Primary.pink
        
        emailField.backgroundColor = .systemGray6
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = UIColor.systemGray4.cgColor
        emailField.layer.cornerRadius = 8
        
        passwordField.backgroundColor = .systemGray6
        passwordField.layer.borderWidth = 1
        passwordField.layer.borderColor = UIColor.systemGray4.cgColor
        passwordField.layer.cornerRadius = 8
        
        nicknameField.backgroundColor = .systemGray6
        nicknameField.layer.borderWidth = 1
        nicknameField.layer.borderColor = UIColor.systemGray4.cgColor
        nicknameField.layer.cornerRadius = 8
        
        locationField.backgroundColor = .systemGray6
        locationField.layer.borderWidth = 1
        locationField.layer.borderColor = UIColor.systemGray4.cgColor
        locationField.layer.cornerRadius = 8

        recommendField.backgroundColor = .systemGray6
        recommendField.layer.borderWidth = 1
        recommendField.layer.borderColor = UIColor.systemGray4.cgColor
        recommendField.layer.cornerRadius = 8
        
        signUpButton.backgroundColor = Color.Primary.pink
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = UIColor.systemGray4.cgColor
        signUpButton.layer.cornerRadius = 10
        
        addInfoSwitch.onTintColor = Color.Primary.pink
    }

    func configureData() {
        titleLabel.text = Text.SignUp.title
        emailField.placeholder = "이메일 주소 또는 전화번호"
        passwordField.placeholder = "비밀번호"
        nicknameField.placeholder = "닉네임"
        locationField.placeholder = "위치"
        recommendField.placeholder = "추천 코드"
        signUpButton.setTitle("회원가입", for: .normal)
        addInfoLabel.text = "추가 정보 입력"
    }
    
    func configureBarBtn() {
        addImgBarBtn(title: nil, image: SystemImage.back!, target: self, action: #selector(backBarBtnClicked), type: .left, color: Color.Primary.pink)
    }
    
    @objc func backBarBtnClicked() {
        navigationController?.popViewController(animated: true)
    }
}
