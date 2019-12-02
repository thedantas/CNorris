//
//  NorrisRouter.swift
//  ChuckNorris
//
//  Created by André  Costa Dantas on 01/12/19.
//  Copyright © 2019 André  Costa Dantas. All rights reserved.
//

import Moya

//MARK: Enum
enum FactsRouter {
    case categories
    case search(String)
}

//MARK: Extension
extension FactsRouter: TargetType {
    
    //MARK: Variables
    var baseURL: URL {
        return URL(string: NetworkingConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .categories:
            return "/categories"
        case .search:
            return "/search"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        switch self {
        case .categories:
            let data = ["animal", "career", "celebrity"]
            return arrayJsonSerializedUTF8(json: data)
        case .search:
            let data = ["total": 6,
                        "result": [["category": ["dev"],
                                    "id": "id",
                                    "url": "thedantas.com",
                                    "value": "blablabla"]
                ]] as [String: Any]
            return jsonSerializedUTF8(json: data)
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .categories:
            return nil
        case .search(let query):
            return ["query": query]
        }
    }
    
    var task: Task {
        if let `parameters` = parameters {
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        } else {
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}

