//
//  Rx+Utils.swift
//  ChuckNorris
//
//  Created by André  Costa Dantas on 01/12/19.
//  Copyright © 2019 André  Costa Dantas. All rights reserved.
//

import RxSwift
import RxCocoa

extension Observable where Element: OptionalType {

    func unwrap() -> Observable<Element.Wrapped> {
        return self.filter { $0.asOptional != nil }.map { $0.asOptional! }
    }

}

protocol OptionalType {
    associatedtype Wrapped
    var asOptional: Wrapped? { get }
}

extension Optional: OptionalType {
    var asOptional: Wrapped? { return self }
}

extension ObservableType where E == String {
    func validateName(filterable: Bool = false) -> Observable<Bool> {
        var result = self.asObservable()
        
        if filterable {
            result = result.filter { $0.count > 0 }
        }
        
        return result.map { value in
            let split = value.split(separator: " ")
            
            if split.count <= 1 {
                return false
            }
            
            for value in 0 ..< split.count where split[value].count <= 1 {
                return false
            }
            
            return true
        }
}
}

