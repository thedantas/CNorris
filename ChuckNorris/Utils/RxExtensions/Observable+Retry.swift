//
//  Observable+Retry.swift
//  ChuckNorris
//
//  Created by André  Costa Dantas on 01/12/19.
//  Copyright © 2019 André  Costa Dantas. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt
import Moya

public extension Observable {

    func retryWhenNeeded() -> Observable<Element> {
        return self
            .retry(
            
                .exponentialDelayed(maxCount: 3, initial: 4, multiplier: 2), shouldRetry: {error in
                    guard let moyaError = error as? MoyaError else {
                        return false
                    }
                    if case let .underlying(error, _) = moyaError {
                        let error = (error as NSError)
                        //Connection error
                        if error.domain == NSURLErrorDomain || 500...599 ~= error.code {
                
                            return true
                        }
                    }
                    return false
        })
    }
}

