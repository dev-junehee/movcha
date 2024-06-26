//
//  SearchView.swift
//  movcha
//
//  Created by junehee on 6/26/24.
//

import UIKit
import SnapKit

class SearchView: BaseView {
    
    // 검색창, 검색 카테고리
    let searchBar = UISearchBar()
    let searchCategory = UISegmentedControl(items: Constants.Text.Search.category)

    // 검색 결과 컬렉션 뷰
    lazy var searchCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionviewLayout()
    )
    
    func collectionviewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let width = UIScreen.main.bounds.width - 48
        let height = UIScreen.main.bounds.height - 60
        
        layout.itemSize = CGSize(width: width / 3, height: height / 5)
        layout.scrollDirection = .vertical // 스크롤 방향
        layout.minimumInteritemSpacing = 12  // 셀과 셀 사이 가로 간격
        layout.minimumLineSpacing = 12 // 셀과 셀 사이 세로 간격
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12) // 셀과 뷰 사이 간격
        
        return layout
    }
    
    override func configureViewHierarchy() {
        let subViews = [searchBar, searchCategory, searchCollectionView]
        subViews.forEach {
            self.addSubview($0)
        }
    }
    
    override func configureViewLayout() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(8)
            $0.height.equalTo(44)
        }
        
        searchCategory.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(32)
        }
        
        searchCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchCategory.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configureViewUI() {
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = Constants.Text.Search.placeholder
    }
}
