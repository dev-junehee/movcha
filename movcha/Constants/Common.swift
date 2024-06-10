//
//  Images.swift
//  movcha
//
//  Created by junehee on 6/4/24.
//

import UIKit

// MARK: Text 텍스트
struct Text {
    // 대표 타이틀
    struct Title {
        static let movcha = "MOVCHA"
        static let home = "홈"
        static let signUp = "회원가입"
        static let boxOffice = "박스오피스"
        static let trending = "인기급상승"
    }
    
    // 홈
    struct Home {
        
    }
    
    // 회원가입
    struct SignUp {
        struct Placeholder {
            static let email = "이메일"
            static let password = "비밀번호"
            static let nickname = "닉네임"
            static let location = "위치"
            static let recommend = "추천 코드"
        }
        
        static let addInfo = "추가 정보 입력하기"
    }
    
    // 박스오피스
    struct BoxOffice {
        static let placeholder = "원하는 날짜를 입력해 주세요! (e.g. 20231206)"
    }
    
    // 인기급상승
    struct Trending {
        static let vote = "평점"
        static let detail = "자세히 보기"
    }
    
    // 버튼
    struct Button {
        static let search = "검색"
        static let ok = "확인"
    }
}


// MARK: Image 이미지
// 시스템 이미지
struct SystemImage {
    static let home = UIImage(systemName: "house.fill")
    static let signUp = UIImage(systemName: "person.crop.circle.fill.badge.plus")
    static let boxOffice = UIImage(systemName: "movieclapper.fill")
    static let trending = UIImage(systemName: "chart.line.uptrend.xyaxis")
    static let list = UIImage(systemName: "list.bullet")
    static let search = UIImage(systemName: "magnifyingglass")
    static let front = UIImage(systemName: "chevron.right")
    static let back = UIImage(systemName: "chevron.backward")
}


// MARK: Color 컬러
struct Color {
    struct Primary {
        static let black = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        static let white = UIColor.white
        static let pink = UIColor(red: 1, green: 0.0196, blue: 0.3451, alpha: 1.0)
        static let gray2 = UIColor.systemGray2
        static let gray4 = UIColor.systemGray4
        static let gray6 = UIColor.systemGray6
        
    }
}


// MARK: Font 폰트
