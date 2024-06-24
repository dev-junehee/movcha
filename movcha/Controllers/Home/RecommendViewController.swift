//
//  RecommendViewController.swift
//  movcha
//
//  Created by junehee on 6/24/24.
//

import UIKit
import SnapKit

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        configureData()
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
        similarCollectionView.tag = 1
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
        searchTitleLabel.text = "온에어"
        searchSubLabel.text = "을(를) 검색했어요!"
        
    }
    
}


extension RecommendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 0-비슷한 콘텐츠
        // 1-추천 콘텐츠
        if collectionView.tag == 0 {
            return 20
        } else {
            return 20
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.id, for: indexPath)
        
        return cell
    }
}
