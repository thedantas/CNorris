//
//  SearchViewModel.swift
//  ChuckNorris
//
//  Created by André  Costa Dantas on 01/12/19.
//  Copyright © 2019 André  Costa Dantas. All rights reserved.
//

import RxSwift
import RxCocoa
import RxSwiftExt
import RxSwiftUtilities

class SearchViewModel {
    
    let recentSearch: Driver<[String]>
    let isRecentSearchHidden: Driver<Bool>
    
    let categories: Driver<[String]>
    let categoriesError: Driver<Error>
    
    let isLoading: Driver<Bool>
    
    let disposeBag = DisposeBag()
    
    init(norrisStorage: NorrisStorage,
         localStorage: UserDefaultsDataStorage) {
        
        let loadingIndicator = ActivityIndicator()
        self.isLoading = loadingIndicator.asDriver()
        
        let categoriesResult = norrisStorage
            .categories()
            .trackActivity(loadingIndicator)
            .retryWhenNeeded()
            .materialize()
            .share()
        
        self.recentSearch = localStorage
            .lastSearch
            .asDriver(onErrorJustReturn: [])
        
        self.isRecentSearchHidden = self.recentSearch
            .map { $0.count == 0 }
            .startWith(true)
        
        self.categories = categoriesResult
            .elements()
            .startWith([])
            .asDriver(onErrorJustReturn: [])
        
        self.categoriesError = categoriesResult
            .errors()
            .asDriver(onErrorJustReturn: NorrisError())
    
    }
}
