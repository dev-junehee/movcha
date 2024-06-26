//
//  RecommendViewController.swift
//  movcha
//
//  Created by junehee on 6/24/24.
//

import UIKit

import Kingfisher
import SnapKit

class RecommendViewController: BaseViewController {
    
    let recommendView = RecommendView()
    
    // 데이터
    var itemTitle: String = ""
    var itemType: Int = 0
    var itemId: Int = 0
    
    var titleList = Constants.Text.Recommend.title
    
    var contentsList: [[SimilarRecommendResults]] = [
        [SimilarRecommendResults(poster_path: "")],
        [SimilarRecommendResults(poster_path: "")]
    ]
    
    override func loadView() {
        self.view = recommendView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureData()
        if itemType == 0 {
            callRequest(type: .movie, id: itemId)
        } else {
            callRequest(type: .tv, id: itemId)
        }
    }
    
    override func configureHierarchy() {
        navigationController?.navigationBar.tintColor = Constants.Color.Primary.pink
        
        recommendView.tableView.delegate = self
        recommendView.tableView.dataSource = self
        recommendView.tableView.register(RecommendTableViewCell.self, forCellReuseIdentifier: RecommendTableViewCell.id)
    }

    private func configureData() {
        recommendView.searchTitleLabel.text = itemTitle
        recommendView.searchSubLabel.text = Constants.Text.Recommend.subSearch
    }
    
}


// MARK: RecommendViewController 익스텐션
// API
extension RecommendViewController {
    func callRequest(type: GenreType, id: Int) {
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.callRequest(api: .similar(type: type, id: id)) { (similar: SimilarRecommend?, error: String?) in
                guard let similar = similar else {
                    print(error ?? "RecommendViewController Call Similar Error")
                    return
                }
                if similar.results.count == 0 {
                    self.showAlert("검색 결과가 없어요!", message: "다른 작품을 검색해 보세요.")
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.contentsList[0] = similar.results
                }
                group.leave()
            }
            
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.callRequest(api: .recommend(type: type, id: id)) { (recommend: SimilarRecommend?, error: String?) in
                guard let recommend = recommend else {
                    print(error ?? "RecommendViewController Call Recommend Error")
                    return
                }
                if recommend.results.count == 0 {
                    self.showAlert("검색 결과가 없어요!", message: "다른 작품을 검색해 보세요.")
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.contentsList[1] = recommend.results
                }
                group.leave()
            }
        }
        
        // 통신 완료되면 테이블 뷰 리로드
        group.notify(queue: .main) {
            self.recommendView.tableView.reloadData()
        }
    }
}

extension RecommendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecommendTableViewCell.id, for: indexPath) as! RecommendTableViewCell
        
        cell.collectionView.tag = indexPath.row
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: RecommendCollectionViewCell.id)
        
        let title = titleList[indexPath.row]
        cell.configureCellData(title: title)
        
        cell.collectionView.reloadData()
        
        return cell
    }
    
    
}

// 컬렉션 뷰
extension RecommendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentsList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.id, for: indexPath) as! RecommendCollectionViewCell

        let data = contentsList[collectionView.tag][indexPath.item]
        cell.configureCellData(data: data)
        
        return cell
    }
}
