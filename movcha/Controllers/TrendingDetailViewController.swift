//
//  TrendingDetailViewController.swift
//  movcha
//
//  Created by junehee on 6/10/24.
//

import UIKit

import Alamofire
import SnapKit

class TrendingDetailViewController: UIViewController {
    
//    var trendingID: Int = 0
    
    let detailImgView = UIImageView()
    
    let titleLabel = UILabel()
    let posterImgView = UIImageView()
    
    let detailTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureHierarchy()
        configureLayout()
        configureUI()
        configureData()
    }
    
    func configureNavigation() {
        view.backgroundColor = .white
        setNavigationTitle(Text.Title.trendingDetail)
        addImgBarBtn(title: nil, image: SystemImage.back!, target: self, action: #selector(backBarBtnClicked), type: .left, color: Color.Primary.pink)
    }
    
    func configureHierarchy() {
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
        detailTableView.register(TrendingDetailOverviewCell.self, forCellReuseIdentifier: TrendingDetailOverviewCell.id)
        detailTableView.register(TrendingDetailCastCell.self, forCellReuseIdentifier: TrendingDetailCastCell.id)
        
        view.addSubview(detailImgView)
        view.addSubview(titleLabel)
        view.addSubview(posterImgView)
        view.addSubview(detailTableView)
    }
    
    func configureLayout() {
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
    
    func configureUI() {
        detailImgView.backgroundColor = .yellow
        titleLabel.backgroundColor = .red
        posterImgView.backgroundColor = .green
        
        detailTableView.backgroundColor = .orange
    }
    
    func configureData() {
        titleLabel.text = "영화제목"
    }
    
    @objc func backBarBtnClicked() {
        navigationController?.popViewController(animated: true)
    }
    
}


extension TrendingDetailViewController: UITableViewDelegate, UITableViewDataSource {
    // 0: Overview
    // 1: Case
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "OverView"
        } else {
            return "Case"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
//        let idx = indexPath.row
        
        if section == 0 {
            let overviewCell = tableView.dequeueReusableCell(withIdentifier: TrendingDetailOverviewCell.id, for: indexPath) as! TrendingDetailOverviewCell
            
            overviewCell.tableView = detailTableView
            
            overviewCell.configureCellHierarchy()
            overviewCell.configureCellLayout()
            overviewCell.configureCellUI()
            overviewCell.configreCellData()
            overviewCell.configureHandler()
            
            return overviewCell
            
        } else {
            let castCell = tableView.dequeueReusableCell(withIdentifier: TrendingDetailCastCell.id, for: indexPath) as! TrendingDetailCastCell
            
            castCell.configureHierarchy()
            castCell.configureLayout()
            castCell.configureUI()
            
            
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
