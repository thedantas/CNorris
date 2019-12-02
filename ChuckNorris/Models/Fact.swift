//
//  Fact.swift
//  ChuckNorris
//
//  Created by André  Costa Dantas on 01/12/19.
//  Copyright © 2019 André  Costa Dantas. All rights reserved.
//

import Foundation

struct Fact: Decodable {
    //MARK: Variables
    let category: [String]
    let iconUrl: String
    let id: String
    let value: String
    
    //MARK: Enum
    enum CodingKeys: String, CodingKey {
        case category
        case iconUrl = "icon_url"
        case id
        case value
    }
    
    //MARK: Init
    init(category: [String] = [],
         id: String = "",
         value: String = "",
         iconUrl: String = "") {
        self.category = category
        self.iconUrl = iconUrl
        self.id = id
        self.value = value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let categories = try container.decodeIfPresent([String].self, forKey: .category) {
            self.category = categories
        } else {
            self.category = ["unknown"]
        }
        self.iconUrl = try container.decode(String.self, forKey: .iconUrl)
        self.id = try container.decode(String.self, forKey: .id)
        self.value = try container.decode(String.self, forKey: .value)
        
    }
}
