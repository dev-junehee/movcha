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

class SearchViewController: UIViewController {
    
    let searchBar = UISearchBar()
    let searchCategory = UISegmentedControl(items: Constants.Text.Search.category)
    
    var selectedSearchCategory = 0
    
    var searchList = Search(page: 0, results: [], total_pages: 0, total_results: 0)
    var page = 0
    
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
        configureCategoryControll()
        setBarButtons()
    }
    
    private func configureHierarchy() {
        navigationItem.title = Constants.Text.Title.search
        view.backgroundColor = .systemBackground
        
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
    
    private func configureLayout() {
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
    
    private func configureUI() {
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
    // 검색
    func callSearchRequest(query: String) {
        var URL = ""
        
        switch searchCategory.selectedSegmentIndex {
        case 0:
            URL = "\(API.URL.KMDB.Search.movie)\(query)"
            break
        case 1:
            URL = "\(API.URL.KMDB.Search.tv)\(query)"
            break
        case 2:
            URL = "\(API.URL.KMDB.Search.person)\(query)"
            break
        default:
            print("검색 카테고리 선택 오류")
        }
        
        let headers: HTTPHeaders = [
            "Authorization": API.KEY.kmdb,
            "accept": "application/json"
        ]
        
        print("API URL 확인", URL)
        AF.request(URL,
                   headers: headers)
        .responseDecodable(of: Search.self) { res in
            switch res.result {
            case .success(let value):
                print("검색 성공")
                print(value.results)
                
                // 새로운 검색어일 때
                if self.page == 1 {
                    self.searchList.results.removeAll()
                    self.searchList.results = value.results
                } else {
                    self.searchList.results.append(contentsOf: value.results)
                }
                
                self.searchCollectionView.reloadData()
    
                if self.page == 1 {
                    self.searchCollectionView.scrollsToTop = true
                }
                
            case .failure(let error):
                print("검색 실패")
                print(error)
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
        callSearchRequest(query: value)
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
        
        for indexPath in indexPaths {
            if searchList.results.count - 2 == indexPath.item {
                page += 1
                callSearchRequest(query: searchBar.text!)
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
        
        cell.searchCategory = searchCategory.selectedSegmentIndex
        
        cell.configureCellHierarchy()
        cell.configureCellLayout()
        cell.configureCellUI()
        cell.configureCellData(data: searchList.results[idx])

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("검색 결과 아이템을 클릭했어요")
        
        let recommendVC = RecommendViewController()
        navigationController?.pushViewController(recommendVC, animated: true)
    }
}
