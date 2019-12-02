//
//  NorrisStorageImpl.swift
//  ChuckNorris
//
//  Created by André  Costa Dantas on 01/12/19.
//  Copyright © 2019 André  Costa Dantas. All rights reserved.
//

import UIKit
import Moya
import RxSwift

class NorrisStorageImpl: NorrisStorage {
    
    let service: NorrisService
    
    init(service: NorrisService) {
        self.service = service
    }
    
    func categories() -> Single<[String]> {
        return self.service.categories()
            .map([String].self)
    }
    
    func search(_ query: String) -> Single<[Fact]> {
        return self.service.search(query)
            .map(FactsNorrisResponse.self)
            .map { $0.result }
    }
}
