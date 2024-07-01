//
//  SignUpViewController.swift
//  movcha
//
//  Created by junehee on 6/4/24.
//

import UIKit

final class SignUpViewController: BaseViewController {
    
    private let signUpView = SignUpView()
    
    override func loadView() {
        self.view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureData()
        configureBarBtn()
        configureHandler()
    }
    
    override func configureHierarchy() {
        signUpView.signUpTextFields.forEach {
            $0.delegate = self
        }
    }
    
    private func configureData() {
        let placeholders = [
            Constants.Text.SignUp.Placeholder.email,
            Constants.Text.SignUp.Placeholder.password,
            Constants.Text.SignUp.Placeholder.nickname,
            Constants.Text.SignUp.Placeholder.location,
            Constants.Text.SignUp.Placeholder.recommend
        ]
        signUpView.signUpTextFields.enumerated().forEach {
            $0.element.setPlaceholder(string: placeholders[$0.offset], color: Constants.Color.Primary.gray2)
        }
        
        signUpView.signUpButton.setTitle(Constants.Text.Title.signUp, for: .normal)
        signUpView.addInfoLabel.text = Constants.Text.SignUp.addInfo
    }
    
    private func configureBarBtn() {
        addImgBarBtn(title: nil, image: Constants.SystemImage.back, target: self, action: #selector(backBarBtnClicked), type: .left, color: Constants.Color.Primary.pink)
    }
    
    private func configureHandler() {
        // 탭 제스쳐
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
        
        // 회원가입 버튼
        signUpView.signUpButton.addTarget(self, action: #selector(signUpBtnClicked), for: .touchUpInside)
    }
    
    // MARK: 이벤트 핸들러
    @objc private func viewTapped() {
        view.endEditing(true)
    }
    
    @objc private func backBarBtnClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func signUpBtnClicked() {
        view.endEditing(true)
        showAlert("준비 중인 기능이에요!", message: nil)
    }
    
}


extension SignUpViewController: UITextFieldDelegate {
    // 리턴 키 눌렀을 때 다음 텍스트 필드로 이동
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case signUpView.emailField:
            signUpView.passwordField.becomeFirstResponder()
            break
        case signUpView.passwordField:
            signUpView.nicknameField.becomeFirstResponder()
            break
        case signUpView.nicknameField:
            signUpView.locationField.becomeFirstResponder()
            break
        case signUpView.locationField:
            signUpView.recommendField.becomeFirstResponder()
            break
        case signUpView.recommendField:
            textField.resignFirstResponder()
            break
        default:
            textField.resignFirstResponder()
        }
        
        return true
    }
}
