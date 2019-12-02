//
//  FactViewModel.swift
//  ChuckNorris
//
//  Created by André  Costa Dantas on 01/12/19.
//  Copyright © 2019 André  Costa Dantas. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class FactItemViewModel {
    
    let fact: PublishSubject<Fact>
    
    let text: Driver<String>
    let backgroundImage: Driver<UIImage?>
    let fontSize: Driver<CGFloat>
    let categories: Driver<[String]>
    
    init() {
        self.fact = PublishSubject<Fact>()
        
        self.text = self.fact
            .map { $0.value }
            .asDriver(onErrorJustReturn: "")
        
        self.backgroundImage = Driver.just(Random.image)
        
        self.fontSize = self.text
            .map {
                return $0.count < 80 ?
                    Constants.largeFontSize : Constants.mediumFontSize
        }
        
        self.categories = self.fact
            .map { $0.category }
            .map { $0.map { "#\($0)" } }
            .asDriver(onErrorJustReturn: [])

    }
    
    func bind(_ fact: Fact) {
        self.fact.onNext(fact)
    }
    
}
