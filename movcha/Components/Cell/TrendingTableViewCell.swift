//
//  TrendingTableViewCell.swift
//  movcha
//
//  Created by junehee on 6/10/24.
//

import UIKit

import Kingfisher
import SnapKit

class TrendingTableViewCell: BaseTableViewCell {
    // 카드 그림자
    let cardBackView = UIView()
    
    // 스택1: 개봉일, 장르
    let dateGenreStack = UIStackView()
    let openDateLabel = UILabel()
    let genreLabel = UILabel()

    // 카드
    let cardView = UIView()
    let cardImg = UIImageView()
    
    // 스택2: 평점
    let voteStack = UIStackView()
    let voteLabel = UILabel()
    let voteAverage = UILabel()
    
    let titleOverviewStack = UIStackView()
    let titleLabel = UILabel()
    let overviewLabel = UILabel()
    
    // 스택3: 자세 보기
    let detailStack = UIStackView()
    let detailLabel = UILabel()
    let detailImgView = UIImageView()

    override func layoutSubviews() {
        super.layoutSubviews()
        // 테이블 뷰 셀 사이의 간격
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }

    override func configureCellHierarchy() {
        let dateGenreViews = [openDateLabel, genreLabel]
        dateGenreViews.forEach {
            dateGenreStack.addArrangedSubview($0)
        }
        
        let voteViews = [voteLabel, voteAverage]
        voteViews.forEach {
            voteStack.addArrangedSubview($0)
        }
        
        let titleOverviews = [titleLabel, overviewLabel]
        titleOverviews.forEach {
            titleOverviewStack.addArrangedSubview($0)
        }
        
        let detailViews: [Any] = [detailLabel, detailImgView]
        detailViews.forEach {
            detailStack.addArrangedSubview($0 as! UIView)
        }
        
        let cardViews = [cardView, cardImg, voteStack, titleOverviewStack, detailStack]
        cardViews.forEach {
            cardBackView.addSubview($0)
        }
        
        contentView.addSubview(dateGenreStack)
        contentView.addSubview(cardBackView)
    }
    
    override func configureCellLayout() {
        dateGenreStack.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(8)
            $0.horizontalEdges.equalTo(contentView).inset(16)
            $0.height.equalTo(44)
        }
        dateGenreStack.axis = .vertical
        dateGenreStack.spacing = 4
        
        cardBackView.snp.makeConstraints {
            $0.top.equalTo(dateGenreStack.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(contentView).inset(16)
            $0.bottom.equalTo(contentView).inset(16)
            $0.height.equalTo(cardBackView.snp.width)
        }

        cardView.snp.makeConstraints {
            $0.horizontalEdges.verticalEdges.equalTo(cardBackView)
        }
        
        cardImg.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(cardView)
            $0.height.equalTo(220)
        }
        
        voteStack.snp.makeConstraints {
            $0.leading.equalTo(cardImg.snp.leading).inset(24)
            $0.bottom.equalTo(cardImg.snp.bottom).inset(24)
            $0.width.equalTo(80)
            $0.height.equalTo(26)
        }
        voteStack.axis = .horizontal
        voteStack.distribution = .fillEqually
        
        titleOverviewStack.snp.makeConstraints {
            $0.top.equalTo(cardImg.snp.bottom)
            $0.horizontalEdges.equalTo(cardView).inset(24)
            $0.height.equalTo(70)
        }
        titleOverviewStack.axis = .vertical

        detailStack.snp.makeConstraints {
            $0.top.equalTo(titleOverviewStack.snp.bottom)
            $0.horizontalEdges.equalTo(cardView).inset(24)
            $0.height.equalTo(40)
            $0.bottom.equalTo(cardView).inset(4)
        }
        detailStack.axis = .horizontal
        detailStack.distribution = .equalSpacing
        
        detailImgView.snp.makeConstraints {
            $0.height.equalTo(10)
        }
        
    }
    
    override func configureCellUI() {
        openDateLabel.textColor = Constants.Color.Primary.gray2
        openDateLabel.font = .systemFont(ofSize: 16)
        genreLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        cardBackView.backgroundColor = Constants.Color.Primary.white
        cardBackView.layer.cornerRadius = 10
        cardBackView.layer.shadowColor = Constants.Color.Primary.black.cgColor
        cardBackView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cardBackView.layer.shadowRadius = 10
        cardBackView.layer.shadowOpacity = 0.5
        
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 10

        cardImg.clipsToBounds = true
        cardImg.layer.cornerRadius = 10
        cardImg.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cardImg.contentMode = .scaleAspectFill
        
        voteStack.backgroundColor = Constants.Color.Primary.white
        voteLabel.backgroundColor = Constants.Color.Primary.pink
        voteLabel.textAlignment = .center
        voteLabel.textColor = Constants.Color.Primary.white
        voteLabel.font = .systemFont(ofSize: 14, weight: .bold)
        voteAverage.textAlignment = .center
        voteAverage.font = .systemFont(ofSize: 14, weight: .semibold)
        
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        overviewLabel.font = .systemFont(ofSize: 14)

        detailStack.clipsToBounds = true
        detailStack.layer.cornerRadius = 10
        detailStack.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        detailLabel.textColor = Constants.Color.Primary.gray2
        detailLabel.font = .systemFont(ofSize: 14)
        
        detailImgView.contentMode = .scaleAspectFit
        detailImgView.tintColor = Constants.Color.Primary.gray2
    }
    
    func configureCellData(data: TrendingResults) {
        openDateLabel.text = data.release_date ?? data.first_air_date
        genreLabel.text = getGenreString(list: data.genre_ids)
        
        voteLabel.text = Constants.Text.Trending.vote
        voteAverage.text = convertDouble(data.vote_average)
        
        let poster = URL(string:"\(API.URL.TMDB.img)\(data.backdrop_path)")
        cardImg.kf.setImage(with: poster)

        titleLabel.text = data.title ?? data.name
        overviewLabel.text = data.overview
        
        detailLabel.text = Constants.Text.Trending.detail
        detailImgView.image = Constants.SystemImage.front
    }
}

extension TrendingTableViewCell {
    func convertDouble(_ double: Double) -> String {
        let strDouble = String(format: "%.1f", double)
        return strDouble
    }
    
    func getGenreString(list: [Int]) -> String {
        var strArr: [String] = []
        list.forEach { id in
            strArr.append("#\(genres[id] ?? "")")
        }
        return strArr.joined(separator: " ")
    }
}

// 임시 장르 데이터
let genres: [Int: String] = [
    12: "모험",
    14: "판타지",
    16: "애니메이션",
    18: "드라마",
    27: "공포",
    28: "액션",
    35: "코미디",
    36: "역사",
    37: "서부",
    53: "스릴러",
    80: "범죄",
    99: "다큐멘터리",
    878: "SF",
    9648: "미스터리",
    10402: "음악",
    10749: "로맨스",
    10751: "가족",
    10752: "전쟁",
    10759: "어드벤쳐",
    10762: "키즈",
    10763: "뉴스",
    10764: "리얼리티",
    10765: "SF-Fantasy",
    10766: "Soap",
    10767: "Talk",
    10768: "전쟁",
    10770: "TV영화",
]
