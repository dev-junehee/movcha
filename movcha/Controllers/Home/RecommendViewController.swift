//
//  RecommendViewController.swift
//  movcha
//
//  Created by junehee on 6/24/24.
//

import UIKit

import Kingfisher
import SnapKit

enum SimilarType {
    case MovieSimilar
    case tv
}

class RecommendViewController: UIViewController {
    
    lazy var tableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(RecommendTableViewCell.self, forCellReuseIdentifier: RecommendTableViewCell.id)
        view.rowHeight = 200
        return view
    }()
    
    let searchTitleLabel = UILabel()
    let searchSubLabel = UILabel()
    
    // 데이터
    var itemTitle: String = ""
    var itemType: Int = 0
    var itemId: Int = 0
    
    var titleList = ["비슷한 콘텐츠", "추천 콘텐츠"]
    
    var similarList: [[SimilarResults]] = [
        [SimilarResults(poster_path: "")],
        [SimilarResults(poster_path: "")]
    ]
    
//    var recommendList
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        configureData()
        callRequest()
    }
    
    private func configureHierarchy() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = Constants.Color.Primary.pink
        
        view.addSubview(searchTitleLabel)
        view.addSubview(searchSubLabel)
        view.addSubview(tableView)
    }
    
    private func configureLayout() {
        searchTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.height.equalTo(40)
        }
        
        searchSubLabel.snp.makeConstraints {
            $0.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.leading.equalTo(searchTitleLabel.snp.trailing).offset(8)
            $0.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchSubLabel.snp.bottom).offset(16)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureUI() {
        searchTitleLabel.font = Constants.Font.title
        
        searchSubLabel.font = .systemFont(ofSize: 14, weight: .regular)
        searchSubLabel.textColor = Constants.Color.Primary.darkGray
        searchSubLabel.baselineAdjustment = .alignBaselines
    }

    private func configureData() {
        searchTitleLabel.text = itemTitle
        searchSubLabel.text = "을(를) 검색했어요!"
    }
    
}


// MARK: RecommendViewController 익스텐션

// API
extension RecommendViewController {
    
    func callRequest() {
        let group = DispatchGroup()
        
        switch itemType {
        case 0:
            group.enter()
            DispatchQueue.global().async(group: group) {
                NetworkManager.shared.getSimilarMovieContents(id: self.itemId) { movieList in
                    if movieList.count == 0 {
                        self.showAlert("검색 결과가 없어요!", message: "다른 작품을 검색해 보세요.")
                        self.navigationController?.popViewController(animated: true)
                        return
                    } else {
                        print("데이터를 확인해요!!!!!!!!!!")
                        dump(movieList)
                        self.similarList[0] = movieList
                    }
                    group.leave()
                }
            }
            break
            
        case 1:
            group.enter()
            DispatchQueue.global().async(group: group) {
                NetworkManager.shared.getSimilarTVContents(id: self.itemId) { tvList in
                    if tvList.count == 0 {
                        self.showAlert("검색 결과가 없어요!", message: "다른 작품을 검색해 보세요.")
                        self.navigationController?.popViewController(animated: true)
                        return
                    } else {
                        print("데이터를 확인해요!!!!!!!!!!")
                        dump(tvList)
                        self.similarList[1] = tvList
                    }
                    group.leave()
                }
            }
            break
            
        default:
            print("영화인은 아직 검색할 수 없어요....")
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
}

extension RecommendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return similarList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecommendTableViewCell.id, for: indexPath) as! RecommendTableViewCell
        
        cell.selectionStyle = .none
        
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
        return similarList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.id, for: indexPath) as! RecommendCollectionViewCell
        
        let data = similarList[collectionView.tag][indexPath.item]
        cell.configureCellData(data: data)
        
        return cell
    }
}
