//
//  HomeViewController.swift
//  movcha
//
//  Created by junehee on 6/4/24.
//

import UIKit
import SideMenu

class HomeViewController: BaseViewController {
    
    let homeView = HomeView()
    let menu = SideMenuNavigationController(rootViewController: SideMenuViewController())
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBarButtons()
        menu.leftSide = true
    }
    
    func setBarButtons() {
        addImgBarBtn(title: nil, image: Constants.SystemImage.list, target: self, action: #selector(menuBtnClicked), type: .left, color: Constants.Color.Primary.pink)
        addImgBarBtn(title: nil, image: Constants.SystemImage.search, target: self, action: #selector(searchBtnClicked), type: .right, color: Constants.Color.Primary.pink)
    }

    // MARK: 핸들러
    @objc private func menuBtnClicked() {
        present(menu, animated: true, completion: nil)
    }
    
    @objc private func searchBtnClicked() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
}
