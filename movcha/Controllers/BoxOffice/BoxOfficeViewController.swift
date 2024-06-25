//
//  BoxOfficeViewController.swift
//  movcha
//
//  Created by junehee on 6/6/24.
//

import UIKit

import Alamofire
import SkeletonView
import SnapKit

class BoxOfficeViewController: UIViewController {
    
    let mainTitle = UILabel()
    
    let searchAreaStack = UIStackView()
    let dateTextField = UITextField()
    let searchButton = UIButton()
    
    let boxOfficeTableView = UITableView()
    
    var boxOfficeList: [BoxOfficeList] = []
    
    var searchDate = "20240605"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        boxOfficeTableView.isSkeletonable = true
        boxOfficeTableView.showGradientSkeleton()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
          self.view.hideSkeleton()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureHierarchy()
        configureLayout()
        configureUI()
        configureData()
        configureHandler()
        callRequest()
    }
    
    func configureHierarchy() {
        let searchAreaViews = [dateTextField, searchButton]
        searchAreaViews.forEach {
            searchAreaStack.addArrangedSubview($0)
        }
        
        let subviews = [mainTitle, searchAreaStack, boxOfficeTableView]
        subviews.forEach {
            view.addSubview($0)
        }
        
        boxOfficeTableView.delegate = self
        boxOfficeTableView.dataSource = self
        boxOfficeTableView.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.id)
        
        boxOfficeTableView.separatorStyle = .none
        boxOfficeTableView.keyboardDismissMode = .onDrag
    }
    
    func configureLayout() {
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(50)
        }
        
        searchAreaStack.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(40)
        }
        searchAreaStack.spacing = 8
        searchAreaStack.alignment = .fill
        
        dateTextField.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(searchAreaStack)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(searchAreaStack)
            make.width.equalTo(60)
        }
        
        boxOfficeTableView.snp.makeConstraints { make in
            make.top.equalTo(searchAreaStack.snp.bottom).offset(12)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureUI() {
        mainTitle.font = .systemFont(ofSize: 40, weight: .black)
        
        dateTextField.borderStyle = .none
        dateTextField.layer.borderWidth = 1
        dateTextField.layer.cornerRadius = 10
        dateTextField.layer.borderColor = Constants.Color.Primary.gray6.cgColor
        dateTextField.font = .systemFont(ofSize: 12)
        dateTextField.keyboardType = .numberPad
        dateTextField.addPadding(type: .left, amount: 12)
        
        searchButton.backgroundColor = Constants.Color.Primary.pink
        searchButton.layer.cornerRadius = 10
        searchButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
    }
    
    func configureData() {
        mainTitle.text = Constants.Text.Title.boxOffice
        dateTextField.setPlaceholder(string: Constants.Text.BoxOffice.placeholder, color: Constants.Color.Primary.gray2)
        searchButton.setTitle(Constants.Text.Button.search, for: .normal)
    }
    
    func configureHandler() {
        searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
    }
    
    func callRequest() {
        let URL = "\(API.URL.KOBIS.boxOffice)?key=\(API.KEY.kobis)&targetDt=\(searchDate)"
        AF.request(URL).responseDecodable(of: BoxOfficeResponse.self) { res in
            switch res.result {
            case .success(let data):
                print("영진위 데이터 불러오기 성공")
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                  self.view.hideSkeleton()
                }
                self.boxOfficeList = data.boxOfficeResult.dailyBoxOfficeList
                self.boxOfficeTableView.reloadData()
            case .failure(let error):
                print("영진위 API 통신 실패")
                print(error)
            }
        }
    }
    
    @objc func searchButtonClicked() {
        // 유효성 검사
        let res = dateTextField.validationText()

        if !(res[0] as! Bool) {
            let title = res[1] as! String
            showAlert(title, message: nil)
            return
        }
        
        // 유효성 검사 통과 시 다시 callRequest
        searchDate = dateTextField.text ?? searchDate
        callRequest()
        
        // textField 클리어 & 키보드 내리기
        dateTextField.text = ""
        view.endEditing(true)
    }
}


// MARK: BoxOfficeViewController Extension

extension BoxOfficeViewController: UITableViewDelegate, UITableViewDataSource, SkeletonTableViewDataSource {
    // Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxOfficeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = boxOfficeTableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.id, for: indexPath) as! BoxOfficeTableViewCell
        
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
