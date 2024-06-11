//
//  ReuseableProtocol.swift
//  movcha
//
//  Created by junehee on 6/4/24.
//

import UIKit

protocol ReuseableProtocol: AnyObject {
    static var id: String { get }
}

extension UIViewController: ReuseableProtocol {
    static var id: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseableProtocol {
    static var id: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReuseableProtocol {
    static var id: String {
        return String(describing: self)
    }
}
