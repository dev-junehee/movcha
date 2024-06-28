//
//  TrendingViewController.swift
//  movcha
//
//  Created by junehee on 6/10/24.
//

import UIKit

import Alamofire
import SnapKit

class TrendingViewController: BaseViewController {

    let mainTitle = UILabel()
    let trendingTableView = UITableView()

    var trendingList: [TrendingResults] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureData()
        callRequest()
    }
    
    override func configureHierarchy() {
        let subviews = [mainTitle, trendingTableView]
        subviews.forEach {
            view.addSubview($0)
        }
        
        trendingTableView.delegate = self
        trendingTableView.dataSource = self
        trendingTableView.register(TrendingTableViewCell.self, forCellReuseIdentifier: TrendingTableViewCell.id)
        trendingTableView.separatorStyle = .none
    }
    
    override func configureLayout() {
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(50)
        }
        
        trendingTableView.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
        mainTitle.font = .systemFont(ofSize: 40, weight: .black)
    }
    
    func configureData() {
        mainTitle.text = Constants.Text.Title.trending
    }
    
    func callRequest() {
        NetworkManager.shared.callRequest(api: .trending) { (trendingList: Trending? , error: String?) in
            guard error == nil else {
                self.showAlert("잠시 후 다시 시도해주세요.", message: error ?? "인기급상승 결과를 가져오지 못했어요.")
                return
            }
            
            guard let trendingList = trendingList else {
                self.showAlert("인기급상승 데이터가 존재하지 않아요.", message: "이전 화면으로 돌아갈게요.")
                self.navigationController?.popViewController(animated: true)
                return
            }
            
            // error가 nil이면 성공 데이터가 들어왔다는 의미
            self.trendingList = trendingList.results
            self.trendingTableView.reloadData()
        }
    }
    
}

// MARK: 인기급상승 컨트롤러 익스텐션

extension TrendingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTableViewCell.id, for: indexPath) as! TrendingTableViewCell
        
        let idx = indexPath.row
        let trendingData = trendingList[idx]
     
        cell.selectionStyle = .none
        cell.configureCellData(data: trendingData)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, indexPath.row)
        let detailNav = TrendingDetailViewController()

        navigationController?.pushViewController(detailNav, animated: true)
    }
}
    
