//
//  TrendingViewController.swift
//  movcha
//
//  Created by junehee on 6/10/24.
//

import UIKit

final class TrendingViewController: BaseViewController {
    
    private let trendingView = TrendingView()
    
    private var trendingList: [TrendingResults] = []
    
    override func loadView() {
        self.view = trendingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest()
    }
    
    override func configureHierarchy() {
        trendingView.trendingTableView.delegate = self
        trendingView.trendingTableView.dataSource = self
        trendingView.trendingTableView.register(TrendingTableViewCell.self, forCellReuseIdentifier: TrendingTableViewCell.id)
        trendingView.trendingTableView.separatorStyle = .none
    }
    
}


// MARK: 인기급상승 컨트롤러 익스텐션
extension TrendingViewController {
    private func callRequest() {
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
            self.trendingView.trendingTableView.reloadData()
        }
    }
}

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
        let trendingDetailVC = TrendingDetailViewController()
        
        let idx = indexPath.row
        let trendingData = trendingList[idx]
        
        trendingDetailVC.contentsData = trendingData

        navigationController?.pushViewController(trendingDetailVC, animated: true)
    }
}
    
