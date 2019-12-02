//
//  HeaderView+Rx.swift
//  ChuckNorris
//
//  Created by André  Costa Dantas on 01/12/19.
//  Copyright © 2019 André  Costa Dantas. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: HeaderView {
    
    var fractionComplete: Binder<CGFloat> {
        return Binder(self.base) { header, fractionComplete in
            header.fractionComplete = fractionComplete
        }
    }
    
    var searchTap: ControlEvent<Void> {
        return self.base.searchButton.rx.tap
    }
    
    var search: Driver<String> {
        return self.base.searchTextField.rx.text
            .asObservable()
            .unwrap()
            .asDriver(onErrorJustReturn: "")
    }
    
}
