//
//  NorrisServiceImpl.swift
//  ChuckNorris
//
//  Created by André  Costa Dantas on 01/12/19.
//  Copyright © 2019 André  Costa Dantas. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class NorrisServiceRouterProvider: NorrisService {
    
    //MARK: Variables
    let provider: MoyaProvider<FactsRouter>
    
    //MARK: Init
    init(provider: MoyaProvider<FactsRouter>) {
        self.provider = provider
    }
    
    //MARK: Functions
    func categories() -> Single<Response> {
        return self.provider.rx.request(.categories)
    }
    
    func search(_ query: String) -> Single<Response> {
        return self.provider.rx.request(.search(query))
    }
}

