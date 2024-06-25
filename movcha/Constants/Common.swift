//
//  Images.swift
//  movcha
//
//  Created by junehee on 6/4/24.
//

import UIKit

enum Constants {
    // MARK: 텍스트
    enum Text {
        // 대표 타이틀
        enum Title {
            static let movcha = "MOVCHA"
            static let home = "홈"
            static let signUp = "회원가입"
            static let boxOffice = "박스오피스"
            static let trending = "인기급상승"
            static let trendingDetail = "상세정보"
            static let search = "작품 검색"
        }
        
        // 홈
        enum Home {
            
        }
        
        // 검색
        enum Search {
            static let category = ["영화", "TV 시리즈", "영화인"]
            static let movie = "영화"
            static let tv = "TV 시리즈"
            static let person = "영화인"
            static let placeholder = "영화, 드라마, 시리즈를 검색해 보세요!"
        }
        
        enum Recommend {
            static let title = ["비슷한 콘텐츠", "추천 콘텐츠"]
            static let subSearch = "을(를) 검색했어요!"
        }
        
        // 회원가입
        enum SignUp {
            enum Placeholder {
                static let email = "이메일"
                static let password = "비밀번호"
                static let nickname = "닉네임"
                static let location = "위치"
                static let recommend = "추천 코드"
            }
            
            static let addInfo = "추가 정보 입력하기"
        }
        
        // 박스오피스
        enum BoxOffice {
            static let placeholder = "원하는 날짜를 입력해 주세요! (e.g. 20231206)"
        }
        
        // 인기급상승
        enum Trending {
            static let vote = "평점"
            static let detail = "자세히 보기"
        }
        
        // 인기급상승 - 상세정보
        enum TrendingDetail {
            
        }
        
        // 버튼
        enum Button {
            static let search = "검색"
            static let ok = "확인"
        }
    }
    
    // MARK: Image 이미지
    // 시스템 이미지
    enum SystemImage {
        static let home = UIImage(systemName: "house.fill")!
        static let signUp = UIImage(systemName: "person.crop.circle.fill.badge.plus")!
        static let boxOffice = UIImage(systemName: "movieclapper.fill")!
        static let trending = UIImage(systemName: "chart.line.uptrend.xyaxis")!
        static let list = UIImage(systemName: "list.bullet")!
        static let search = UIImage(systemName: "magnifyingglass")!
        static let front = UIImage(systemName: "chevron.right")!
        static let back = UIImage(systemName: "chevron.backward")!
        static let down = UIImage(systemName: "chevron.down")!
    }


    // MARK: Color 컬러
    enum Color {
        enum Primary {
            static let black = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
            static let white = UIColor.white
            static let pink = UIColor(red: 1, green: 0.0196, blue: 0.3451, alpha: 1.0)
            static let darkGray = UIColor.darkGray
            static let gray2 = UIColor.systemGray2
            static let gray4 = UIColor.systemGray4
            static let gray6 = UIColor.systemGray6
            
        }
    }

    // MARK: Font 폰트
    enum Font {
        static let title: UIFont = .systemFont(ofSize: 40, weight: .black)
        static let subTitle: UIFont = .systemFont(ofSize: 20, weight: .black)
    }
}



