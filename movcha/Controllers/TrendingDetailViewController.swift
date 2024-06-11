//
//  TrendingDetailViewController.swift
//  movcha
//
//  Created by junehee on 6/10/24.
//

import UIKit

class TrendingDetailViewController: UIViewController {
    
    let trendingData: [TrendingResults] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation()
    }
    
    func configureNavigation() {
        setNavigationTitle(Text.Title.trendingDetail)
        addImgBarBtn(title: nil, image: SystemImage.back! , target: self, action: #selector(backBarBtnClicked), type: .left, color: Color.Primary.pink)
    }
    
    
    
    
    
    @objc func backBarBtnClicked() {
        navigationController?.popViewController(animated: true)
    }
    
}
