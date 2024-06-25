//
//  HomeViewController.swift
//  movcha
//
//  Created by junehee on 6/4/24.
//

import UIKit
import SnapKit

class HomeViewController: BaseViewController {
    
    let mainTitle = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        configureHierarchy()
//        configureLayout()
//        configureUI()
//        configureData()
        setBarButtons()
    }
    
    override func configureHierarchy() {
        let subviews = [mainTitle]
        subviews.forEach {
            view.addSubview($0)
        }
    }
    
    override func configureLayout() {
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(50)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        mainTitle.font = .systemFont(ofSize: 40, weight: .black)
        mainTitle.text = Constants.Text.Title.home
    }
    
//    func configureData() {
//        
//    }
    
    func setBarButtons() {
        addImgBarBtn(title: nil, image: Constants.SystemImage.search, target: self, action: #selector(searchBtnClicked), type: .right, color: Constants.Color.Primary.pink)
    }

    // MARK: 핸들러

    @objc func searchBtnClicked() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
}
