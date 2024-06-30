//
//  SignUpView.swift
//  movcha
//
//  Created by junehee on 6/29/24.
//

import UIKit
import SnapKit

class SignUpView: BaseView {
    
    let titleImg = UIImageView()
    
    let emailField = UITextField()
    let passwordField = UITextField()
    let nicknameField = UITextField()
    let locationField = UITextField()
    let recommendField = UITextField()
    
    var signUpTextFields: [UITextField] = []
    
    let signUpButton = UIButton()
    
    let addInfoLabel = UILabel()
    let addInfoSwitch = UISwitch()
    
    override func configureViewHierarchy() {
        let subViews: [UIView] = [titleImg, emailField, passwordField, nicknameField, locationField, recommendField, signUpButton, addInfoLabel, addInfoSwitch]
        
        for subview in subViews {
            self.addSubview(subview)
        }
        
        signUpTextFields = [emailField, passwordField, nicknameField, locationField, recommendField
        ]
    }
    
    override func configureViewLayout() {
        titleImg.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(32)
            $0.centerX.equalTo(self)
        }
        
        emailField.snp.makeConstraints {
            $0.top.equalTo(titleImg.snp.bottom)
            $0.centerX.equalTo(self)
            $0.size.equalTo(CGSize(width: 300, height: 40))
        }
        
        passwordField.snp.makeConstraints {
            $0.top.equalTo(emailField.snp.bottom).offset(8)
            $0.centerX.equalTo(self)
            $0.size.equalTo(CGSize(width: 300, height: 40))
        }
        
        nicknameField.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(8)
            $0.centerX.equalTo(self)
            $0.size.equalTo(CGSize(width: 300, height: 40))
        }
        
        locationField.snp.makeConstraints {
            $0.top.equalTo(nicknameField.snp.bottom).offset(8)
            $0.centerX.equalTo(self)
            $0.size.equalTo(CGSize(width: 300, height: 40))
        }
        
        recommendField.snp.makeConstraints {
            $0.top.equalTo(locationField.snp.bottom).offset(8)
            $0.centerX.equalTo(self)
            $0.size.equalTo(CGSize(width: 300, height: 40))
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(recommendField.snp.bottom).offset(16)
            $0.centerX.equalTo(self)
            $0.size.equalTo(CGSize(width: 300, height: 50))
        }
        
        addInfoLabel.snp.makeConstraints {
            $0.top.equalTo(signUpButton.snp.bottom).offset(16)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(45)
        }
        
        addInfoSwitch.snp.makeConstraints {
            $0.top.equalTo(signUpButton.snp.bottom).offset(16)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(45)
        }
    }
    
    override func configureViewUI() {
        titleImg.image = UIImage.movchaLogo
        
        signUpTextFields.forEach {
            setSignUpTextFieldUI($0)
        }
        
        addInfoLabel.textColor = Constants.Color.Primary.gray2
        addInfoLabel.font = .systemFont(ofSize: 14)
        
        signUpButton.backgroundColor = Constants.Color.Primary.pink
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.layer.cornerRadius = 10
        signUpButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        
        addInfoSwitch.onTintColor = Constants.Color.Primary.pink
    }
    
}

extension SignUpView {
    // 회원가입 텍스트 필드 UI 세팅
    func setSignUpTextFieldUI(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Constants.Color.Primary.gray6.cgColor
        textField.layer.cornerRadius = 8
        textField.font = .systemFont(ofSize: 12)
        textField.addPadding(type: .left, amount: 12)
    }
}
