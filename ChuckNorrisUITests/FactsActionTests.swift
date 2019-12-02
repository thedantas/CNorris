//
//  MainFlowTests.swift
//  ChuckNorrisUITests
//
//  Created by Andre Costa Dantas on 02/12/19.
//  Copyright © 2019 André  Costa Dantas. All rights reserved.
//

import Foundation
import KIF
import Swinject
import RxSwift

@testable import ChuckNorris

class FactsActionTests: BaseUITest {
    
    override func configureContainer(container: Container) {
        container.register(LocalStorage.self) { _ in
            return UserDefaultsDataStorage()
        }
        
        container.register(NorrisStorage.self) { _ in
            return self.mockRepository
        }
    }
    
    func testSeeStartViewOnOpening() {
        expectToSeeStartView()
    }
    
    func testSeeSearchView() {
        tapOnSearchView()
        expectToSeeSearchView()
    }
    
    func testSearchOnCategoryTap() {
        tapOnSearchView()
        tapOnCategory("category")
        expectToSeeLoadingView()
        expectToSeeFactsList()
    }
    
    func testSearchOnRecentSearchTap() {
        tapOnSearchView()
        tapOnRecentSearch("search")
        expectToSeeLoadingView()
        expectToSeeFactsList()
    }
    
    func testSearchOnButtonTap() {
        tapOnSearchView()
        fillSearch()
        tapOnSearchButton()
        expectToSeeLoadingView()
        expectToSeeFactsList()
    }
    
    func testSearchEmptyResults() {
        mockRepository.emptyResponse = true
        
        tapOnSearchView()
        fillSearch()
        tapOnSearchButton()
        expectToSeeLoadingView()
        expectToSeeEmptyView()
    }
    
    func testSecondSearchEmpty() {
        tapOnSearchView()
        fillSearch()
        tapOnSearchButton()
        expectToSeeLoadingView()
        expectToSeeFactsList()
        
        mockRepository.emptyResponse = true
        
        tapOnSearchView()
        fillSearch()
        tapOnSearchButton()
        expectToSeeEmptyView()
    }
    
    func testErrorResponse() {
        mockRepository.success = false
        
        tapOnSearchView()
        fillSearch()
        tapOnSearchButton()
        expectToSeeErrorView()
        
    }
    
    func testErrorWhenContentAvailable() {
        //normal search with results
        tapOnSearchView()
        fillSearch()
        tapOnSearchButton()
        expectToSeeFactsList()
        
        mockRepository.success = false
        
        tapOnSearchView()
        fillSearch()
        tapOnSearchButton()
        expectToSeeErrorToastView()
    }
}
extension FactsActionTests {
    
    // MARK: Actions
    
    func tapOnSearchView() {
        tapOnView("search")
    }
    
    func tapOnRecentSearch(_ pastSearch: String) {
        tapOnView(pastSearch)
    }
    
    // MARK: ExperctView
    
    func expectToSeeStartView() {
        expectToSee("start_view")
    }
    
    func expectToSeeErrorView() {
        expectToSee("error_view")
    }
    
    func expectToSeeEmptyView() {
        expectToSee("empty_view")
    }
    
    func expectToSeeSearchView() {
        expectToSee("search_view")
    }
    
    func expectToSeeFactsList() {
        expectToSee("facts_table_view")
    }
    
}
