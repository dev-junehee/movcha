//
//  HomeViewController.swift
//  movcha
//
//  Created by junehee on 6/4/24.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBarBtn()
    }
    
    func configureBarBtn() {
        addImgBarBtn(title: nil, image: SystemImage.signUp!, target: self, action: #selector(signUpBarButtonClicked), type: .right, color: Color.Primary.pink)
    }
    
    @objc func signUpBarButtonClicked() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
}
