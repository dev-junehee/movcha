//
//  SignUpViewController.swift
//  movcha
//
//  Created by junehee on 6/4/24.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureLayout()
        configureUI()
        configureData()
        configureBarBtn()
        configureHandler()
    }
    
    func configureHierarchy() {
        view.backgroundColor = .systemBackground
        
        // 서브 뷰 추가
        let subViews: [UIView] = [titleImg, emailField, passwordField, nicknameField, locationField, recommendField, signUpButton, addInfoLabel, addInfoSwitch]
        
        for subview in subViews {
            view.addSubview(subview)
        }
        
        // 텍스트 필드 Delegate
        signUpTextFields = [emailField, passwordField, nicknameField, locationField, recommendField]
        
        signUpTextFields.forEach {
            $0.delegate = self
        }
    }

    func configureLayout() {
        titleImg.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            make.centerX.equalTo(view)
        }
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(titleImg.snp.bottom)
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 300, height: 40))
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(8)
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 300, height: 40))
        }
        
        nicknameField.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(8)
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 300, height: 40))
        }
        
        locationField.snp.makeConstraints { make in
            make.top.equalTo(nicknameField.snp.bottom).offset(8)
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 300, height: 40))
        }
        
        recommendField.snp.makeConstraints { make in
            make.top.equalTo(locationField.snp.bottom).offset(8)
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

    func configureData() {

        let placeholders = [
            Constants.Text.SignUp.Placeholder.email,
            Constants.Text.SignUp.Placeholder.password,
            Constants.Text.SignUp.Placeholder.nickname,
            Constants.Text.SignUp.Placeholder.location,
            Constants.Text.SignUp.Placeholder.recommend
        ]
        signUpTextFields.enumerated().forEach {
            $0.element.setPlaceholder(string: placeholders[$0.offset], color: Constants.Color.Primary.gray2)
        }
        
        signUpButton.setTitle(Constants.Text.Title.signUp, for: .normal)
        addInfoLabel.text = Constants.Text.SignUp.addInfo
    }
    
    func configureBarBtn() {
        addImgBarBtn(title: nil, image: Constants.SystemImage.back, target: self, action: #selector(backBarBtnClicked), type: .left, color: Constants.Color.Primary.pink)
    }
    
    func configureHandler() {
        // 탭 제스쳐
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
        
        // 회원가입 버튼
        signUpButton.addTarget(self, action: #selector(signUpBtnClicked), for: .touchUpInside)
    }
    
    // MARK: 이벤트 핸들러
    @objc func viewTapped() {
        view.endEditing(true)
    }
    
    @objc func backBarBtnClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func signUpBtnClicked() {
        view.endEditing(true)
    }
    
}


// MARK: 회원가입 컨트롤러 익스텐션

extension SignUpViewController {
    // 회원가입 텍스트 필드 UI 세팅
    func setSignUpTextFieldUI(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Constants.Color.Primary.gray6.cgColor
        textField.layer.cornerRadius = 8
        textField.font = .systemFont(ofSize: 12)
        textField.addPadding(type: .left, amount: 12)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    // 리턴 키 눌렀을 때 다음 텍스트 필드로 이동
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.emailField:
            self.passwordField.becomeFirstResponder()
            break
        case self.passwordField:
            self.nicknameField.becomeFirstResponder()
            break
        case self.nicknameField:
            self.locationField.becomeFirstResponder()
            break
        case self.locationField:
            self.recommendField.becomeFirstResponder()
            break
        case self.recommendField:
            textField.resignFirstResponder()
            break
        default:
            textField.resignFirstResponder()
        }
        
        return true
    }
}
