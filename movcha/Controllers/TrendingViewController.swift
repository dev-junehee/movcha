//
//  TrendingViewController.swift
//  movcha
//
//  Created by junehee on 6/10/24.
//

import UIKit

import Alamofire
import SnapKit

class TrendingViewController: UIViewController {

    let mainTitle = UILabel()
    let trendingTableView = UITableView()
    
    var trendingList: [TrendingResults] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
        configureData()
        callRequest()
        setBarButtons()
    }
    
    func configureHierarchy() {
        let subviews = [mainTitle, trendingTableView]
        subviews.forEach {
            view.addSubview($0)
        }
        
        trendingTableView.delegate = self
        trendingTableView.dataSource = self
        trendingTableView.register(TrendingTableViewCell.self, forCellReuseIdentifier: TrendingTableViewCell.id)
        trendingTableView.separatorStyle = .none
    }
    
    func configureLayout() {
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
    
    func configureUI() {
        mainTitle.font = .systemFont(ofSize: 40, weight: .black)

    }
    
    func configureData() {
        mainTitle.text = Text.Title.trending
    }
    
    func callRequest() {
        let header: HTTPHeaders = [
            "Authorization": API.KEY.kmdb,
            "accept": "application/json"
        ]
        
        AF.request(API.URL.trending,
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: header)
        .responseDecodable(of: Trending.self) { res in
            switch res.result {
            case .success(let value):
                print("성공")
                self.trendingList = value.results
                self.trendingTableView.reloadData()
            case .failure(let error):
                print("실패")
                print(error)
            }
        }
    }
    
    
    func setBarButtons() {
        addImgBarBtn(title: nil, image: SystemImage.list!, target: self, action: #selector(menuBtnClicked), type: .left, color: Color.Primary.pink)
        addImgBarBtn(title: nil, image: SystemImage.search!, target: self, action: #selector(searchBtnClicked), type: .right, color: Color.Primary.pink)
    }

    // MARK: 핸들러
    @objc func menuBtnClicked() {
        print(#function)
    }
    
    @objc func searchBtnClicked() {
        print(#function)
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
        
        cell.configureCellHierarchy()
        cell.configureCellLayout()
        cell.configureCellUI()
        cell.configureCellData(data: trendingData)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, indexPath.row)
    }
}
