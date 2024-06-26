//
//  SearchViewController.swift
//  movcha
//
//  Created by junehee on 6/11/24.
//

import UIKit

import Alamofire
import Kingfisher
import SnapKit

class SearchViewController: BaseViewController {
    
    let searchBar = UISearchBar()
    let searchCategory = UISegmentedControl(items: Constants.Text.Search.category)
    
    var selectedSearchCategory = 0
    
    var searchList = Search(page: 1, results: [], total_pages: 0, total_results: 0)
    var page = 1
    
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
        
        configureCategoryControll()
        setBarButtons()
    }
    
    override func configureHierarchy() {
        navigationItem.title = Constants.Text.Title.search
        
        searchBar.delegate = self
        
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.id)
        searchCollectionView.prefetchDataSource = self
        searchCollectionView.keyboardDismissMode = .onDrag
        
        view.addSubview(searchBar)
        view.addSubview(searchCategory)
        view.addSubview(searchCollectionView)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(44)
        }
        
        searchCategory.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(32)
        }
        searchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchCategory.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = Constants.Text.Search.placeholder
    }
    
    private func setBarButtons() {
        addImgBarBtn(title: nil, image: Constants.SystemImage.back, target: self, action: #selector(backBarBtnClicked), type: .left, color: Constants.Color.Primary.pink)
    }

    @objc func backBarBtnClicked() {
        navigationController?.popViewController(animated: true)
    }
}


// MARK: 검색 뷰컨트롤러 익스텐션

// API
extension SearchViewController {
    func callSearchRequest(type: SearchType, query: String) {
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async {
            NetworkManager.shared.callRequest(api: .search(type: type, query: query)) { (search: Search?, error: String?) in
                guard let search = search else {
                    print(error ?? "SearchViewController Call Search Error")
                    return
                }
                if self.page == 1 {
                    self.searchList.results.removeAll()
                    self.searchList.results = search.results
                } else {
                    self.searchList.results.append(contentsOf: search.results)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.searchCollectionView.reloadData()

            if self.page == 1 {
                self.searchCollectionView.scrollsToTop = true
            }
        }
    }
}


// SearchBar
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let value = searchBar.text else {
            print(#function, "검색어 입력 오류")
            return
        }
        
        if selectedSearchCategory == 0 {
            callSearchRequest(type: .movie, query: value)
        } else if selectedSearchCategory == 1 {
            callSearchRequest(type: .tv, query: value)
        } else {
            callSearchRequest(type: .person, query: value)
        }
        
    }
}

// Segmented Control
extension SearchViewController {
    func configureCategoryControll() {
        searchCategory.selectedSegmentIndex = 0
        searchCategory.addTarget(self, action: #selector(categoryChanged), for: .valueChanged)
    }
    
    @objc func categoryChanged() {
        selectedSearchCategory = searchCategory.selectedSegmentIndex
    }
    
}

// TableView DatasourceFetching
extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("Prefetch", indexPaths)
        guard let value = searchBar.text else { return }
        for indexPath in indexPaths {
            if searchList.results.count - 2 == indexPath.item {
                page += 1
                if selectedSearchCategory == 0 {
                    callSearchRequest(type: .movie, query: value)
                } else if selectedSearchCategory == 1 {
                    callSearchRequest(type: .tv, query: value)
                } else {
                    callSearchRequest(type: .person, query: value)
                }
            }
        }
    }
}

// CollectionView
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.id, for: indexPath) as! SearchCollectionViewCell
        
        let idx = indexPath.item
        let item = searchList.results[idx]
        
        cell.searchCategory = searchCategory.selectedSegmentIndex
        cell.configureCellData(data: item)
 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedSearchCategory == 2 {
            showAlert("영화인 연관 검색은 아직 준비 중이에요!", message: nil)
            return
        }
        
        let item = searchList.results[indexPath.item]
        
        let recommendVC = RecommendViewController()
        recommendVC.itemTitle = item.name ?? item.title!
        recommendVC.itemType = selectedSearchCategory
        recommendVC.itemId = item.id
        
        navigationController?.pushViewController(recommendVC, animated: true)
    }
}
