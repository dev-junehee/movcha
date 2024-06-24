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
    
    let searchTitleLabel = UILabel()
    let searchSubLabel = UILabel()
    
    let similarTitleLabel = UILabel()
    lazy var similarCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: recommendCollectionViewLayout()
    )
    
    let recommendTitleLabel = UILabel()
    lazy var recommendCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: recommendCollectionViewLayout()
    )
    
    func recommendCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 8
        
        let width = UIScreen.main.bounds.width - spacing
        let height = UIScreen.main.bounds.height
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: width / 3, height: height)
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(
            top: spacing,
            left: spacing,
            bottom: spacing,
            right: 0
        )
        
        return layout
    }

    
    // 데이터
    var itemTitle: String = ""
    var itemType: Int = 0
    var itemId: Int = 0
    
    var similarList: [TVSimilarResults] = []
//    var recommendList
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("타이틀이 잘 들어오나요?", itemTitle)
        print("미디어 타입이 잘 들어오나요?", itemType)
        print("아이디가 잘 들어오나요?", itemId)
        
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
        view.addSubview(similarTitleLabel)
        view.addSubview(similarCollectionView)
        view.addSubview(recommendTitleLabel)
        view.addSubview(recommendCollectionView)
        
        // 비슷한 콘텐츠 컬렉션 뷰
        similarCollectionView.delegate = self
        similarCollectionView.dataSource = self
        similarCollectionView.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: RecommendCollectionViewCell.id)
        similarCollectionView.tag = 0
        
        // 추천 콘텐츠 컬렉션 뷰
        recommendCollectionView.delegate = self
        recommendCollectionView.dataSource = self
        recommendCollectionView.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: RecommendCollectionViewCell.id)
        recommendCollectionView.tag = 1
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
        
        similarTitleLabel.snp.makeConstraints {
            $0.top.equalTo(searchTitleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(30)
        }
        
        similarCollectionView.snp.makeConstraints {
            $0.top.equalTo(similarTitleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(180)
        }
        
        recommendTitleLabel.snp.makeConstraints {
            $0.top.equalTo(similarCollectionView.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(30)
        }
        
        recommendCollectionView.snp.makeConstraints {
            $0.top.equalTo(recommendTitleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(180)
        }
        
        
    }
    
    private func configureUI() {
        searchTitleLabel.font = Constants.Font.title
        
        searchSubLabel.font = .systemFont(ofSize: 14, weight: .regular)
        searchSubLabel.textColor = Constants.Color.Primary.darkGray
        searchSubLabel.baselineAdjustment = .alignBaselines

        similarTitleLabel.text = "비슷한 콘텐츠"
        similarTitleLabel.font = Constants.Font.subTitle
        recommendTitleLabel.text = "추천 콘텐츠"
        recommendTitleLabel.font = Constants.Font.subTitle
        
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
        switch itemType {
        case 0:
            NetworkManager.shared.getSimilarMovieContents(id: itemId)
            break
        case 1:
            NetworkManager.shared.getSimilarTVContents(id: itemId) { data in
                if data.results.count == 0 {
                    self.showAlert("검색 결과가 없어요!", message: "다른 작품을 검색해 보세요.")
                    self.navigationController?.popViewController(animated: true)
                    return
                } else {
                    self.similarList = data.results
                    self.similarCollectionView.reloadData()
                }
            }
            break
        default:
            print("영화인은 아직 검색할 수 없어요....")
        }
    }
}



// 컬렉션 뷰
extension RecommendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 0-비슷한 콘텐츠
        // 1-추천 콘텐츠
        if collectionView == similarCollectionView {
            return similarList.count
        } else {
            return similarList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.id, for: indexPath) as! RecommendCollectionViewCell
        
        if collectionView == similarCollectionView {
            let item = similarList[indexPath.item]
            cell.configureCellData(data: item)
            return cell
        } else {
            let item = similarList[indexPath.item]
            cell.configureCellData(data: item)
            return cell
        }
    }
}
