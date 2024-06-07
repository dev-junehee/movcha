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
        
        emailField.backgroundColor = Color.Primary.gray6
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = Color.Primary.gray4.cgColor
        emailField.layer.cornerRadius = 8
        emailField.font = .systemFont(ofSize: 12)
        emailField.addPadding(type: .left, amount: 12)
        
        passwordField.backgroundColor = Color.Primary.gray6
        passwordField.layer.borderWidth = 1
        passwordField.layer.borderColor = Color.Primary.gray4.cgColor
        passwordField.layer.cornerRadius = 8
        passwordField.font = .systemFont(ofSize: 12)
        passwordField.addPadding(type: .left, amount: 12)
        
        nicknameField.backgroundColor = Color.Primary.gray6
        nicknameField.layer.borderWidth = 1
        nicknameField.layer.borderColor = Color.Primary.gray4.cgColor
        nicknameField.layer.cornerRadius = 8
        nicknameField.font = .systemFont(ofSize: 12)
        nicknameField.addPadding(type: .left, amount: 12)
        
        locationField.backgroundColor = Color.Primary.gray6
        locationField.layer.borderWidth = 1
        locationField.layer.borderColor = Color.Primary.gray4.cgColor
        locationField.layer.cornerRadius = 8
        locationField.font = .systemFont(ofSize: 12)
        locationField.addPadding(type: .left, amount: 12)

        recommendField.backgroundColor = Color.Primary.gray6
        recommendField.layer.borderWidth = 1
        recommendField.layer.borderColor = Color.Primary.gray4.cgColor
        recommendField.layer.cornerRadius = 8
        recommendField.font = .systemFont(ofSize: 12)
        recommendField.addPadding(type: .left, amount: 12)
        
        addInfoLabel.textColor = Color.Primary.gray2
        addInfoLabel.font = .systemFont(ofSize: 14)
        
        signUpButton.backgroundColor = Color.Primary.pink
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = Color.Primary.gray4.cgColor
        signUpButton.layer.cornerRadius = 10
        signUpButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        
        addInfoSwitch.onTintColor = Color.Primary.pink
    }

    func configureData() {
        titleLabel.text = Text.Title.movcha
        
        emailField.setPlaceholder(string: Text.SignUp.Placeholder.email, color: .lightGray)
        passwordField.setPlaceholder(string: Text.SignUp.Placeholder.password, color: .lightGray)
        nicknameField.setPlaceholder(string: Text.SignUp.Placeholder.nickname, color: .lightGray)
        locationField.setPlaceholder(string: Text.SignUp.Placeholder.location, color: .lightGray)
        recommendField.setPlaceholder(string: Text.SignUp.Placeholder.recommend, color: .lightGray)
        
        signUpButton.setTitle(Text.Title.signUp, for: .normal)
        addInfoLabel.text = Text.SignUp.addInfo
    }
    
    func configureBarBtn() {
        addImgBarBtn(title: nil, image: SystemImage.back!, target: self, action: #selector(backBarBtnClicked), type: .left, color: Color.Primary.pink)
    }
    
    @objc func backBarBtnClicked() {
        navigationController?.popViewController(animated: true)
    }
}
