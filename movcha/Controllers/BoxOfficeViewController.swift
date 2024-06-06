//
//  BoxOfficeViewController.swift
//  movcha
//
//  Created by junehee on 6/6/24.
//

import UIKit
import Alamofire
import SnapKit

struct BoxOfficeResponse: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [BoxOfficeList]
}

struct BoxOfficeList: Decodable {
    let rnum: String
    let rank: String
    let rankInten: String
    let rankOldAndNew: String
    let movieCd: String
    let movieNm: String
    let openDt: String
    let salesAmt: String
    let salesShare: String
    let salesInten: String
    let salesChange: String
    let salesAcc: String
    let audiCnt: String
    let audiInten: String
    let audiChange: String
    let audiAcc: String
    let scrnCnt: String
    let showCnt: String
}

class BoxOfficeViewController: UIViewController {
    
    let mainTitle = UILabel()
    
    let searchAreaStack = UIStackView()
    let dateTextField = UITextField()
    let searchButton = UIButton()
    
    let boxOfficeTableView = UITableView()
    
    var boxOfficeList: [BoxOfficeList] = []
    var searchDate = "20240605"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("박스 오피스 화면 진입")
        
        configureHierarchy()
        configureLayout()
        configureUI()
        configureData()
        
//        callRequest()
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
            make.top.equalTo(searchAreaStack.snp.bottom).offset(8)
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
        dateTextField.layer.borderColor = Color.Primary.gray.cgColor
        dateTextField.font = .systemFont(ofSize: 12)
        dateTextField.keyboardType = .numberPad
        dateTextField.addPadding(type: .left, amount: 12)
        
        searchButton.backgroundColor = Color.Primary.pink
        searchButton.layer.cornerRadius = 10
    }
    
    func configureData() {
        mainTitle.text = "박스오피스"
        dateTextField.setPlaceholder(string: "원하는 날짜를 입력해 주세요! (e.g. 20231206)", color: .gray)
        searchButton.setTitle("검색", for: .normal)
    }
    
    func callRequest() {
        let URL = "\(API.URL.boxOffice)?key=\(API.KEY.movie)&targetDt=\(searchDate)"
        AF.request(URL).responseDecodable(of: BoxOfficeResponse.self) { res in
            switch res.result {
            case .success(let data):
                print("영진위 데이터 불러오기 성공")
                print(data)
                self.boxOfficeList = data.boxOfficeResult.dailyBoxOfficeList
                self.boxOfficeTableView.reloadData()
            case .failure(let error):
                print("영진위 API 통신 실패")
                print(error)
            }
        }
    }
}

extension BoxOfficeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = boxOfficeTableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.id, for: indexPath) as! BoxOfficeTableViewCell
        
        cell.configureCellHierarchy()
        cell.configureCellLayout()
        cell.configureCellUI()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}