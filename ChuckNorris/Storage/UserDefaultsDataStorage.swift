//
//  UserDefaultsDataStorage.swift
//  ChuckNorris
//
//  Created by André  Costa Dantas on 01/12/19.
//  Copyright © 2019 André  Costa Dantas. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol UserDefaultsDataStorage: class {
    var lastSearch: Observable<[String]> { get }
    func addSearch(_ string: String)
}
