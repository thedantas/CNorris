//
//  NorrisStorage.swift
//  ChuckNorris
//
//  Created by André  Costa Dantas on 01/12/19.
//  Copyright © 2019 André  Costa Dantas. All rights reserved.
//

import RxSwift
import Moya

protocol NorrisStorage: class {
    func categories() -> Single<[String]>
    func search(_ query: String) -> Single<[Fact]>
}

struct NorrisError: LocalizedError {
    let message: String
    
    init(message: String = "Error. If you had any problems, contact Chuck Norris to resolven") {
        self.message = message
    }
    
    var errorDescription: String? {
        return self.message
    }
}
