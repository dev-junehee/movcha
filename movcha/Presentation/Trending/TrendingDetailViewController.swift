//
//  TrendingDetailViewController.swift
//  movcha
//
//  Created by junehee on 6/10/24.
//

import UIKit
import Kingfisher

final class TrendingDetailViewController: BaseViewController {
    
    private let detailView = TrendingDetailView()
    
    // 데이터
    var contentsData: TrendingResults?
    var contentsType: GenreType = .movie
    var creditList: [Cast] = []
    
    override func loadView() {
        self.view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureData()
        callRequest()
    }
    
    private func configureNavigation() {
        setNavigationTitle(Constants.Text.Title.trendingDetail)
        addImgBarBtn(title: nil, image: Constants.SystemImage.back, target: self, action: #selector(backBarBtnClicked), type: .left, color: Constants.Color.Primary.pink)
    }
    
    override func configureHierarchy() {
        detailView.detailTableView.delegate = self
        detailView.detailTableView.dataSource = self
        
        detailView.detailTableView.register(TrendingDetailOverviewCell.self, forCellReuseIdentifier: TrendingDetailOverviewCell.id)
        detailView.detailTableView.register(TrendingDetailCastCell.self, forCellReuseIdentifier: TrendingDetailCastCell.id)
    }
    
    override func configureUI() {
        super.configureUI()
        
        detailView.titleLabel.textColor = Constants.Color.Primary.white
        detailView.posterImgView.contentMode = .scaleAspectFit
    }
    
    private func configureData() {
        guard let contentsData = contentsData else { return }
        detailView.titleLabel.text = contentsData.title
        
        let posterImage = URL(string: API.URL.TMDB.img + contentsData.poster_path)
        detailView.posterImgView.kf.setImage(with: posterImage)
        
        let detailImage = URL(string: API.URL.TMDB.img + contentsData.backdrop_path)
        detailView.detailImgView.kf.setImage(with: detailImage)
    }
    
    @objc private func backBarBtnClicked() {
        navigationController?.popViewController(animated: true)
    }
    
}


// MARK: 익스텐션
extension TrendingDetailViewController {
    private func callRequest() {
        guard let contentsData = contentsData else { return }
        NetworkManager.shared.callRequest(
            api: .credits(type: contentsType, id: contentsData.id)) { (creditsList: Credits?, error: String?) in
                guard error == nil else {
                    self.showAlert("잠시 후 다시 시도해주세요.", message: error ?? "콘텐츠 크레딧 결과를 가져오지 못했어요.")
                    self.navigationController?.popViewController(animated: true)
                    return
                }
                
                guard let creditsList = creditsList else {
                    self.showAlert("콘텐츠 크레딧 데이터가 존재하지 않아요.", message: "이전 화면으로 돌아갈게요.")
                    self.navigationController?.popViewController(animated: true)
                    return
                }
                
                self.creditList = creditsList.cast
                self.detailView.detailTableView.reloadData()
            }
    }
}

extension TrendingDetailViewController: UITableViewDelegate, UITableViewDataSource {
    // 0: Overview, 1: Cast
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return creditList.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return Constants.Text.TrendingDetail.overview
        } else {
            return Constants.Text.TrendingDetail.cast
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let idx = indexPath.row
        
        if section == 0 {
            let overviewCell = tableView.dequeueReusableCell(withIdentifier: TrendingDetailOverviewCell.id, for: indexPath) as! TrendingDetailOverviewCell
            
            overviewCell.tableView = detailView.detailTableView
            overviewCell.configreCellData(data: contentsData?.overview ?? Constants.Text.TrendingDetail.noOverview)
            overviewCell.configureHandler()
            
            return overviewCell
            
        } else {
            let castCell = tableView.dequeueReusableCell(withIdentifier: TrendingDetailCastCell.id, for: indexPath) as! TrendingDetailCastCell
  
            let castData = creditList[idx]
            castCell.configureCellData(data: castData)
            
            return castCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        
        if section == 0 {
            return UITableView.automaticDimension
        } else {
            return 120
        }
    }
    
}
