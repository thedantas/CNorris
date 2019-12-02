//
//  CategoriesTagView.swift
//  ChuckNorris
//
//  Created by André  Costa Dantas on 01/12/19.
//  Copyright © 2019 André  Costa Dantas. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: CategoriesTagView {
    
    var items: Binder<[String]> {
        return Binder(self.base) { tagView, items in
            tagView.items = items
        }
    }
    
    var tagSelected: Driver<String> {
        return base.collectionView.rx.modelSelected(String.self)
                .asDriver(onErrorJustReturn: "")
    }
    
}
