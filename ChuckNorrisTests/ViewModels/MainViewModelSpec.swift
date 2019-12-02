//
//  MainViewModelSpec.swift
//  ChuckNorrisTests
//
//  Created by Andre Costa Dantas on 02/12/19.
//  Copyright © 2019 André  Costa Dantas. All rights reserved.
//

import Foundation
import Swinject
import RxSwift
import RxCocoa
import Quick
import Nimble

@testable import InstaNorris

class MainViewModelSpec: QuickSpec {
    
    override func spec() {
        //MARK: Variables
        var subject: MainViewModel!
        
        let searchSubject = PublishSubject<String>()
        let recentSearchFactsSubject = PublishSubject<String>()
        let search = searchSubject.asDriver(onErrorJustReturn: "")
        let recentSearch = recentSearchFactsSubject.asDriver(onErrorJustReturn: "")
        
        describe("MainViewModel behavior") {
            
            context("Success search") {
                
                beforeEach {
                    let local = UserDefaultsDataStorage()
                    let storage = NorrisStorage()
                    subject = MainViewModel(input:
                        (search: search,
                         categorySelected: category,
                         recentSearchSelected: recentSearch),
                                            norrisStorage: local,
                                            localStorage: storage)
                }
                
                it("regular search") {
                    
                    var result: [Fact] = []
                    
                    subject.results.drive(onNext: {
                        result = $0
                    }).disposed(by: self.rx.disposeBag)
                    
                    searchSubject.onNext("Test")
                    
                    expect(result).toEventuallyNot(beEmpty(), timeout: 5)
                    
                }
                
                it("past search") {
                    
                    var result: [Fact] = []
                    
                    subject.results.drive(onNext: {
                        result = $0
                    }).disposed(by: self.rx.disposeBag)
                    
                    recentSearchFactsSubject.onNext("Test")
                    
                    expect(result).toEventuallyNot(beEmpty(), timeout: 5)
                    
                }
                
                
            }
            
            context("search error") {
                
                beforeEach {
                    let dataStorage = UserDefaultsDataStorage(success: false)
                    let storage = NorrisStorage()
                    subject = MainViewModel(input:
                        (search: search,
                         categorySelected: category,
                         recentSearchSelected: recentSearch),
                                            norrisStorage: dataStorage,
                                            localStorage: storage)
                }
                
                it("error") {
                    var result: Error?
                    
                    subject.searchError.drive(onNext: {
                        result = $0
                    }).disposed(by: self.rx.disposeBag)
                    
                    searchSubject.onNext("Test")
                    
                    expect(result).toEventuallyNot(beNil(), timeout: 5)
                }
                
            }
            
        }
        
    }
    
}
