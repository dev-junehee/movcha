//
//  LoadingView.swift
//  movcha
//
//  Created by junehee on 7/2/24.
//

import UIKit
import SnapKit

class LoadingView: BaseView {
    
    private let backgroundView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.Primary.white
        return view
    }()
    
    let indicator = UIActivityIndicatorView(style: .large)
    
    override func configureViewHierarchy() {
        self.addSubview(backgroundView)
        self.addSubview(indicator)
    }
    
    override func configureViewLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        indicator.snp.makeConstraints {
            $0.center.equalTo(backgroundView)
        }
    }
    
}
