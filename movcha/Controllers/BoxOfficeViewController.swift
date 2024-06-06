//
//  BoxOfficeViewController.swift
//  movcha
//
//  Created by junehee on 6/6/24.
//

import UIKit
import Alamofire

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
    
    var boxOfficeList: [BoxOfficeList] = []
    var searchDate = "20240605"

    override func viewDidLoad() {
        super.viewDidLoad()
        print("박스 오피스 화면 진입")

        callRequest()
    }
    
    func callRequest() {
        let URL = "\(API.URL.boxOffice)?key=\(API.KEY.movie)&targetDt=\(searchDate)"
        print("URL", URL)
        print("디코딩시작")
        AF.request(URL).responseDecodable(of: BoxOfficeResponse.self) { res in
            switch res.result {
            case .success(let data):
                print("영진위 데이터 불러오기 성공")
                print(data)
                self.boxOfficeList = data.boxOfficeResult.dailyBoxOfficeList
                // 테이블 뷰 리로드
            case .failure(let error):
                print("영진위 API 통신 실패")
                print(error)
            }
        }
    }
}
