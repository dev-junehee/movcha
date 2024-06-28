//
//  SideMenuTableViewCell.swift
//  movcha
//
//  Created by junehee on 6/29/24.
//

import UIKit
import SnapKit

class SideMenuTableViewCell: BaseTableViewCell {
    
    let menuIcon = UIImageView()
    let menuLabel = UILabel()
    
    override func configureCellHierarchy() {
        self.addSubview(menuIcon)
        self.addSubview(menuLabel)
    }
    
    override func configureCellLayout() {
        menuIcon.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.centerY.equalToSuperview()
        }
        
        menuLabel.snp.makeConstraints {
            $0.leading.equalTo(menuIcon.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
        }
    }
    
    override func configureCellUI() {
        menuIcon.tintColor = Constants.Color.Primary.pink
        menuLabel.font = Constants.Font.small
        menuLabel.textColor = Constants.Color.Primary.darkGray
        menuLabel.textAlignment = .left
    }
    
    func configureCellData(icon: UIImage?, title: String) {
        guard let icon = icon else { return }
        menuIcon.image = icon
        menuLabel.text = title
    }
    
}
