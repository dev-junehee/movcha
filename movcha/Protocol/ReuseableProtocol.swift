//
//  ReuseableProtocol.swift
//  movcha
//
//  Created by junehee on 6/4/24.
//

import Foundation

protocol ReuseableProtocol: AnyObject {
    static var identifier: String { get }
}
