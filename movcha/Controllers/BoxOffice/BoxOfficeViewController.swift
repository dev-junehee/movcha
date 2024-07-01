//
//  BoxOfficeViewController.swift
//  movcha
//
//  Created by junehee on 6/6/24.
//

import UIKit

import Alamofire
import SkeletonView

final class BoxOfficeViewController: BaseViewController {
    
    private let boxOfficeView = BoxOfficeView()
    
    private var boxOfficeList: [BoxOfficeList] = []
    private var searchDate = "20240605"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        boxOfficeView.tableView.isSkeletonable = true
        boxOfficeView.tableView.showGradientSkeleton()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
          self.view.hideSkeleton()
        }
    }
    
    override func loadView() {
        self.view = boxOfficeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureData()
        configureHandler()
        callRequest()
    }
    
    override func configureHierarchy() {
        boxOfficeView.tableView.delegate = self
        boxOfficeView.tableView.dataSource = self
        boxOfficeView.tableView.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.id)
    }
    
    private func configureData() {
        boxOfficeView.dateTextField.setPlaceholder(string: Constants.Text.BoxOffice.placeholder, color: Constants.Color.Primary.gray2)
        boxOfficeView.searchButton.setTitle(Constants.Text.Button.search, for: .normal)
    }
    
    private func configureHandler() {
        boxOfficeView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
    }
    
    @objc private func searchButtonClicked() {
        // 유효성 검사
        let res = boxOfficeView.dateTextField.validationText()

        if !(res[0] as! Bool) {
            let title = res[1] as! String
            showAlert(title, message: nil)
            return
        }
        
        // 유효성 검사 통과 시 다시 callRequest
        searchDate = boxOfficeView.dateTextField.text ?? searchDate
        callRequest()
        
        // textField 클리어 & 키보드 내리기
        boxOfficeView.dateTextField.text = ""
        view.endEditing(true)
    }
}


// MARK: BoxOfficeViewController Extension
extension BoxOfficeViewController {
    private func callRequest() {
        let URL = "\(API.URL.KOBIS.boxOffice)?key=\(API.KEY.kobis)&targetDt=\(searchDate)"
        AF.request(URL).responseDecodable(of: BoxOfficeResponse.self) { res in
            switch res.result {
            case .success(let data):
                print("영진위 데이터 불러오기 성공")
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                  self.view.hideSkeleton()
                }
                self.boxOfficeList = data.boxOfficeResult.dailyBoxOfficeList
                self.boxOfficeView.tableView.reloadData()
            case .failure(let error):
                print("영진위 API 통신 실패")
                print(error)
            }
        }
    }
}

extension BoxOfficeViewController: UITableViewDelegate, UITableViewDataSource, SkeletonTableViewDataSource {
    // Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxOfficeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.id, for: indexPath) as! BoxOfficeTableViewCell
        
        let idx = indexPath.row
        let boxOffice = boxOfficeList[idx]
        
        cell.selectionStyle = .none
        
        cell.configureCellHierarchy()
        cell.configureCellLayout()
        cell.configureCellUI()
        cell.configureCellData(data: boxOffice)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // Skeleton View
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 1
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxOfficeList.count
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return BoxOfficeTableViewCell.id
    }
}
