//
//  NorrisService.swift
//  ChuckNorris
//
//  Created by André  Costa Dantas on 01/12/19.
//  Copyright © 2019 André  Costa Dantas. All rights reserved.
//

import RxSwift
import Moya

//MARK: Protocol
protocol NorrisService {
    func categories()-> Single<Response>
    func search(_ query: String) -> Single<Response>
}
