//
//  SearchViewModelTest.swift
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

@testable import ChuckNorris

class SearchViewModelTest: QuickSpec {
    
    override func spec() {
        var subject: SearchViewModel!
        
        describe("SearchViewModel") {
            context("sucess") {
                
                beforeEach {
        
                    let storage = UserDefaultsDataStorage()
                    
                    subject = SearchViewModel(localStorage: storage)
                }
                
                it("recent search with success") {
                    do {
                        let result = try subject.recentSearch
                            .toBlocking(timeout: 1)
                            .first()
                        
                        expect(result).toNot(beEmpty())
                    } catch {
                        assert(false, error.localizedDescription)
                    }
                }
                
                it("showing recent search") {
                    
                    do {
                        let result = try subject.isRecentSearchHidden
                            .asObservable()
                            .skip(1)
                            .toBlocking(timeout: 2)
                            .first()
                        
                        expect(result).to(beFalse())
                    } catch {
                        assert(false, error.localizedDescription)
                    }
                }
            }
            
            describe("categories with error") {
                beforeEach {
                    let dataStorage = UserDefaultsDataStorage(success: false)
                    let storage = MockLocalStorage()
                    
                    subject = SearchViewModel(norrisStorage: dataStorage, localStorage: storage)
                }
                
                it("error") {
                    do {
                        let result = try subject.categoriesError
                            .toBlocking(timeout: 2)
                            .first()
                        
                        expect(result).toNot(beNil())
                    } catch {
                        assert(false, error.localizedDescription)
                    }
                }
            }
            
            describe("empty recent search") {
                beforeEach {
                    let dataStorage = UserDefaultsDataStorage()
                    let storage = MockLocalStorage(isEmpty: true)
                    
                    subject = SearchViewModel(norrisStorage: dataStorage, localStorage: storage)
                }
                
                it("hidden recent search") {
                    
                    do {
                        let isHidden = try subject.isRecentSearchHidden.asObservable().toBlocking(timeout: 1).first()
                        expect(isHidden).to(beTrue())
                    } catch {
                        assert(false, error.localizedDescription)
                    }
                }
            }
        }
        
    }
    
}

