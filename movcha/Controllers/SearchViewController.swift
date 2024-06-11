//
//  SearchViewController.swift
//  movcha
//
//  Created by junehee on 6/11/24.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    let searchBar = UISearchBar()
    
    lazy var searchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionviewLayout())
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        setBarButtons()
    }
    
    func configureHierarchy() {
        navigationItem.title = "작품 검색"
        view.backgroundColor = .systemBackground
        
        searchBar.delegate = self
        
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.id)
        searchCollectionView.prefetchDataSource = self
        
        
        view.addSubview(searchBar)
        view.addSubview(searchCollectionView)
    }
    
    func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(44)
        }
        
        searchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureUI() {
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "영화, 드라마, 시리즈를 검색해 보세요!"
        
        searchCollectionView.backgroundColor = .lightGray
    }
    
    func setBarButtons() {
        addImgBarBtn(title: "홈으로 가기", image: SystemImage.back!, target: self, action: #selector(backBarBtnClicked), type: .left, color: Color.Primary.pink)
    }

    @objc func backBarBtnClicked() {
        navigationController?.popViewController(animated: true)
    }
}


// MARK: 검색 뷰컨트롤러 익스텐션
// SearchBar
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        print(searchBar.text!)
    }
}

// TableView DatasourceFetching
extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("Prefetch", indexPaths)
    }

}

// CollectionView
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.id, for: indexPath) as! SearchCollectionViewCell
        
        return cell
    }
    
}
