//
//  HomeViewController.swift
//  movcha
//
//  Created by junehee on 6/4/24.
//

import UIKit
import SideMenu

final class HomeViewController: BaseViewController {
    
    private let homeView = HomeView()
    private let menu = SideMenuNavigationController(rootViewController: SideMenuViewController())
    
    private var homeContentTitles = Constants.Text.Home.title
    private var homeContentList: [[HomePosterPaths]] = [
        [HomePosterPaths(poster_path: "")],
        [HomePosterPaths(poster_path: "")],
        [HomePosterPaths(poster_path: "")],
        [HomePosterPaths(poster_path: "")],
    ]
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu.leftSide = true
        setBarButtons()
        callRequest()
    }
    
    override func configureHierarchy() {
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
        homeView.tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.id)
    }
    
    private func setBarButtons() {
        addImgBarBtn(title: nil, image: Constants.SystemImage.list, target: self, action: #selector(menuBtnClicked), type: .left, color: Constants.Color.Primary.pink)
        addImgBarBtn(title: nil, image: Constants.SystemImage.search, target: self, action: #selector(searchBtnClicked), type: .right, color: Constants.Color.Primary.pink)
    }
    
    // MARK: 핸들러
    @objc private func menuBtnClicked() {
        present(menu, animated: true, completion: nil)
    }
    
    @objc private func searchBtnClicked() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
}


// MARK: 익스텐션
extension HomeViewController {
    private func callRequest() {
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.callRequest(api: .trendingMovie) { (homeContentList: Home? , error: String?) in
                guard let homeContentList = homeContentList else {
                    print("홈 화면 - trending movie 실패")
                    return
                }
                self.homeContentList[0] = homeContentList.results
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.callRequest(api: .trendingTV) { (homeContentList: Home? , error: String?) in
                guard let homeContentList = homeContentList else {
                    print("홈 화면 - trending tv 실패")
                    return
                }
                self.homeContentList[1] = homeContentList.results
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.callRequest(api: .topRatedMovie) { (homeContentList: Home? , error: String?) in
                guard let homeContentList = homeContentList else {
                    print("홈 화면 - TopRaged Movie 실패")
                    return
                }
                self.homeContentList[2] = homeContentList.results
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.callRequest(api: .topRatedTV) { (homeContentList: Home? , error: String?) in
                guard let homeContentList = homeContentList else {
                    print("홈 화면 - TopRaged Tv 실패")
                    return
                }
                self.homeContentList[3] = homeContentList.results
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.homeView.tableView.reloadData()
        }
    }
}

// 테이블 뷰
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeContentList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HomeTableViewCell.id,
            for: indexPath
        ) as? HomeTableViewCell else { return HomeTableViewCell() }

        cell.selectionStyle = .none
        cell.collectionView.tag = indexPath.row
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.id)
        
        let title = homeContentTitles[indexPath.row]
        cell.configureCellData(title: title)
        
        cell.collectionView.reloadData()
        
        return cell
    }
}

// 컬렉션 뷰
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeContentList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.id, for: indexPath) as! HomeCollectionViewCell
        
        let data = homeContentList[collectionView.tag][indexPath.row]
        cell.configureCellData(data: data.poster_path)
        
        return cell
    }
}
