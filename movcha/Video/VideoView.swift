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
    
    override func configureViewHierarchy() {
        self.addSubview(webView)
    }
    
    override func configureViewLayout() {
        webView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
