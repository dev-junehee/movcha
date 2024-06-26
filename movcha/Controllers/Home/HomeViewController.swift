//
//  HomeViewController.swift
//  movcha
//
//  Created by junehee on 6/4/24.
//

import UIKit

class HomeViewController: BaseViewController {
    
    let homeView = HomeView()
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBarButtons()
    }
    
    func setBarButtons() {
        addImgBarBtn(title: nil, image: Constants.SystemImage.search, target: self, action: #selector(searchBtnClicked), type: .right, color: Constants.Color.Primary.pink)
    }

    // MARK: 핸들러
    @objc func searchBtnClicked() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
}
