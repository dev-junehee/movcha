//
//  TrendingDetailViewController.swift
//  movcha
//
//  Created by junehee on 6/10/24.
//

import UIKit

import Alamofire
import Kingfisher
import SnapKit

class TrendingDetailViewController: BaseViewController {
    
//    var trendingID: Int = 0

    
    let detailImgView = UIImageView()
    
    let titleLabel = UILabel()
    let posterImgView = UIImageView()
    
    let detailTableView = UITableView()
    
    // 데이터
    var contentsData: TrendingResults?
    var contentsType: GenreType = .movie
    var creditList: [Cast] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureData()
        callRequest()
    }
    
    func configureNavigation() {
        setNavigationTitle(Constants.Text.Title.trendingDetail)
        addImgBarBtn(title: nil, image: Constants.SystemImage.back, target: self, action: #selector(backBarBtnClicked), type: .left, color: Constants.Color.Primary.pink)
    }
    
    override func configureHierarchy() {
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
        detailTableView.register(TrendingDetailOverviewCell.self, forCellReuseIdentifier: TrendingDetailOverviewCell.id)
        detailTableView.register(TrendingDetailCastCell.self, forCellReuseIdentifier: TrendingDetailCastCell.id)
        
        view.addSubview(detailImgView)
        view.addSubview(titleLabel)
        view.addSubview(posterImgView)
        view.addSubview(detailTableView)
    }
    
    override func configureLayout() {
        detailImgView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(detailImgView.snp.top).offset(16)
            make.leading.equalTo(detailImgView.snp.leading).offset(16)
            make.width.equalTo(100)
            make.height.equalTo(36)
        }
        
        posterImgView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalTo(detailImgView.snp.leading).offset(16)
            make.width.equalTo(100)
            make.bottom.equalTo(detailImgView.snp.bottom)
        }
        
        detailTableView.snp.makeConstraints { make in
            make.top.equalTo(detailImgView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
//        detailImgView.backgroundColor = .yellow
        
//        titleLabel.backgroundColor = .red
        titleLabel.textColor = Constants.Color.Primary.white
        
//        posterImgView.backgroundColor = .green
        posterImgView.contentMode = .scaleAspectFit
        
//        detailTableView.backgroundColor = .orange
    }
    
    func configureData() {
        guard let contentsData = contentsData else { return }
        titleLabel.text = contentsData.title
        
        let posterImage = URL(string: API.URL.TMDB.img + contentsData.poster_path)
        posterImgView.kf.setImage(with: posterImage)
        
        let detailImage = URL(string: API.URL.TMDB.img + contentsData.backdrop_path)
        detailImgView.kf.setImage(with: detailImage)
    }
    
    func callRequest() {
        guard let contentsData = contentsData else { return }
        NetworkManager.shared.callRequest(
            api: .credits(type: contentsType, id: contentsData.id)) { (creditsList: Credits?, error: String?) in
                guard error == nil else {
                    self.showAlert("잠시 후 다시 시도해주세요.", message: error ?? "콘텐츠 크레딧 결과를 가져오지 못했어요.")
                    return
                }
                
                guard let creditsList = creditsList else {
                    self.showAlert("콘텐츠 크레딧 데이터가 존재하지 않아요.", message: "이전 화면으로 돌아갈게요.")
                    self.navigationController?.popViewController(animated: true)
                    return
                }
                
                print(error)
                dump(creditsList)
                
                self.creditList = creditsList.cast
                self.detailTableView.reloadData()
            }
    }
    
    @objc func backBarBtnClicked() {
        navigationController?.popViewController(animated: true)
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
            return "OverView"
        } else {
            return "Cast"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let idx = indexPath.row
        
        if section == 0 {
            let overviewCell = tableView.dequeueReusableCell(withIdentifier: TrendingDetailOverviewCell.id, for: indexPath) as! TrendingDetailOverviewCell
            
            overviewCell.tableView = detailTableView
            overviewCell.configreCellData(data: contentsData?.overview ?? "줄거리 없음")
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
            return 100
        }
    }
    
}
