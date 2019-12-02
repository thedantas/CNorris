//
//  RandomImage.swift
//  ChuckNorris
//
//  Created by André  Costa Dantas on 01/12/19.
//  Copyright © 2019 André  Costa Dantas. All rights reserved.
//

import Foundation
import UIKit

class Random {
    
    static let imagesCount = 9
    
    static var image: UIImage? {
        let random = randomNumber(2...9)
        return UIImage(named: "image_\(random)")
    }
}

public func randomNumber<T: SignedInteger>(_ range: ClosedRange<T> = 1...6) -> T {
    let length = Int64(range.upperBound - range.lowerBound + 1)
    let value = Int64(arc4random()) % length + Int64(range.lowerBound)
    return T(value)
}
