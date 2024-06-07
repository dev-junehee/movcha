//
//  Images.swift
//  movcha
//
//  Created by junehee on 6/4/24.
//

import UIKit

// MARK: Text 텍스트
struct Text {
    struct TabBar {
        static let home = "홈"
        static let signUp = "회원가입"
        static let boxOffice = "박스오피스"
    }
    
    struct Home {
        
    }
    
    struct SignUp {
        static let title = "MOVCHA"
    }
    
    struct BoxOffice {
        
    }
    
}

// MARK: Image 이미지
// 시스템 이미지
struct SystemImage {
    static let home = UIImage(systemName: "house.fill")
    static let signUp = UIImage(systemName: "person.crop.circle.fill.badge.plus")
    static let boxOffice = UIImage(systemName: "movieclapper.fill")
    static let back = UIImage(systemName: "chevron.backward")
}

// MARK: Color 컬러
struct Color {
    struct Primary {
        static let black = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        static let pink = UIColor(red: 1, green: 0.0196, blue: 0.3451, alpha: 1.0)
        static let gray = UIColor.systemGray6
    }
}


// MARK: Font 폰트
