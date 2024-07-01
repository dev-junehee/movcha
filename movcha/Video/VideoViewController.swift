//
//  VideoViewController.swift
//  movcha
//
//  Created by junehee on 7/2/24.
//

import UIKit

final class VideoViewController: BaseViewController {
    
    private let videoView = VideoView()
    
    var contentsId: Int = 0
    var contentsType: GenreType = .movie
    
    private var videoKeyList: [VideoResults] = []
    
    override func loadView() {
        self.view = videoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBarButtons()
        callRequest()
    }
    
    private func setBarButtons() {
        addImgBarBtn(title: nil, image: Constants.SystemImage.back, target: self, action: #selector(backBarBtnClicked), type: .left, color: Constants.Color.Primary.pink)
    }
    
    @objc private func backBarBtnClicked() {
        navigationController?.popViewController(animated: true)
    }
    
}


extension VideoViewController {
    private func callRequest() {
        NetworkManager.shared.callRequest(api: .videos(type: contentsType, id: contentsId)) { (response: Video? , error: String?) in
            guard let response = response?.results else {
                print("검색 결과 오류")
                return
            }
            
            if response.count == 0 {
                self.showAlert("검색 결과가 없어요!", message: "다른 콘텐츠를 검색해 보세요.")
                return
            }
            
            self.videoKeyList = response
            print(self.videoKeyList)
            
//            let random = Int.random(in: 0...self.videoKeyList.count)\
//            self.navigationItem.title = self.videoKeyList[0].name.components(separatedBy: " ").first
            self.configureData(key: self.videoKeyList[0].key)
        }
    }
    
    private func configureData(key: String) {
        guard let URL = URL(string: API.URL.TMDB.Videos.youtube + key) else {
            print("유튜브 링크 오류")
            return
        }
        let request = URLRequest(url: URL)
        videoView.webView.load(request)
    }
}
