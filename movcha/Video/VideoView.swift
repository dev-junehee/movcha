//
//  VideoView.swift
//  movcha
//
//  Created by junehee on 7/2/24.
//

import UIKit
import WebKit

import SnapKit

class VideoView: BaseView {
    
    let webView = WKWebView()
    let loadingView = LoadingView()
    
    var isLoading = false {
        didSet {
            loadingView.isHidden = !isLoading
            webView.isHidden = isLoading
            isLoading ? loadingView.indicator.startAnimating() : loadingView.indicator.stopAnimating()
        }
    }
    
    override func configureViewHierarchy() {
        self.addSubview(webView)
        self.addSubview(loadingView)
    }
    
    override func configureViewLayout() {
        webView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        loadingView.snp.makeConstraints {
            $0.center.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
