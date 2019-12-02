
//
//  SearchResponse.swift
//  ChuckNorris
//
//  Created by André  Costa Dantas on 01/12/19.
//  Copyright © 2019 André  Costa Dantas. All rights reserved.
//

import Foundation

struct FactsNorrisResponse: Decodable {
    let total: Int
    let result: [Fact]
}
