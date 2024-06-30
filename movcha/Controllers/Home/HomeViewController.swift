//
//  HomeViewController.swift
//  movcha
//
//  Created by junehee on 6/4/24.
//

import UIKit
import SideMenu

class HomeViewController: BaseViewController {
    
    let homeView = HomeView()
    let menu = SideMenuNavigationController(rootViewController: SideMenuViewController())
    
    var mainContentList: [String] = ["메인 콘텐츠", "지금 재생 중", "좋아할 거 같은 콘텐츠", "어쩌구 저쩌구"]
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBarButtons()
        menu.leftSide = true
    }
    
    override func configureHierarchy() {
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
        homeView.tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.id)
    }
    
    func setBarButtons() {
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
// 테이블 뷰
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainContentList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HomeTableViewCell.id,
            for: indexPath
        ) as? HomeTableViewCell else { return HomeTableViewCell() }
        
//        cell.backgroundColor = .lightGray

        cell.collectionView.tag = indexPath.row
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.id)
        
        let title = mainContentList[indexPath.row]
        cell.configureCellData(data: title)
        
        return cell
    }
}

// 컬렉션 뷰
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return 1
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.id, for: indexPath) as! HomeCollectionViewCell
        return cell
    }
}
