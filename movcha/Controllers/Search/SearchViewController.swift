//
//  SearchViewController.swift
//  movcha
//
//  Created by junehee on 6/11/24.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    private let searchView = SearchView()
    
    private var page = 1
    private var selectedSearchCategory = 0
    
    private var searchList = Search(page: 1, results: [], total_pages: 0, total_results: 0) {
        didSet {
            viewToggle()
            searchView.searchCollectionView.reloadData()
        }
    }

    override func loadView() {
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCategoryControll()
        setNavigationTitle(Constants.Text.Title.search)
        setBarButtons()
        viewToggle()
    }
    
    override func configureHierarchy() {
        searchView.searchBar.delegate = self
        searchView.searchCollectionView.delegate = self
        searchView.searchCollectionView.dataSource = self
        searchView.searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.id)
        searchView.searchCollectionView.prefetchDataSource = self
        searchView.searchCollectionView.keyboardDismissMode = .onDrag
    }
    
    private func setBarButtons() {
        addImgBarBtn(title: nil, image: Constants.SystemImage.back, target: self, action: #selector(backBarBtnClicked), type: .left, color: Constants.Color.Primary.pink)
    }
    
    private func viewToggle() {
        searchView.emptyView.isHidden = !searchList.results.isEmpty
        searchView.searchCollectionView.isHidden = searchList.results.isEmpty
    }

    @objc private func backBarBtnClicked() {
        navigationController?.popViewController(animated: true)
    }
}


// MARK: 검색 뷰컨트롤러 익스텐션

// API
extension SearchViewController {
    private func callSearchRequest(type: SearchType, query: String) {
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
            self.searchView.searchCollectionView.reloadData()

            if self.page == 1 {
                self.searchView.searchCollectionView.scrollsToTop = true
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
        
        view.endEditing(true)
    }
}

// Segmented Control
extension SearchViewController {
    private func configureCategoryControll() {
        self.searchView.searchCategory.selectedSegmentIndex = 0
        self.searchView.searchCategory.addTarget(self, action: #selector(categoryChanged), for: .valueChanged)
    }
    
    @objc private func categoryChanged() {
        selectedSearchCategory = self.searchView.searchCategory.selectedSegmentIndex
        searchView.searchBar.text = ""
        searchList.results = []
        searchView.searchCollectionView.reloadData()
    }
    
}

// TableView DatasourceFetching
extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("Prefetch", indexPaths)
        guard let value = self.searchView.searchBar.text else { return }
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
        
        cell.searchCategory = self.searchView.searchCategory.selectedSegmentIndex
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
