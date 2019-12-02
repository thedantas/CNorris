//
//  SearchView.swift
//  ChuckNorris
//
//  Created by André  Costa Dantas on 01/12/19.
//  Copyright © 2019 André  Costa Dantas. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import Reusable

class SearchView: UIViewController {
    
    @IBOutlet weak var categoriesCloudView: CategoriesTagView!
    @IBOutlet weak var recentSearchCloudView: CategoriesTagView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: SearchViewModel!
    let norrisRepository: NorrisStorage
    let localStorage: UserDefaultsDataStorage
    
    var categorySelected: Driver<String>!
    var recentSearchSelected: Driver<String>!

    init(norrisRepository: NorrisStorage,
         localStorage: UserDefaultsDataStorage) {
        self.norrisRepository = norrisRepository
        self.localStorage = localStorage
        super.init(nibName: String(describing: SearchView.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        self.setupBindings()
        self.view.accessibilityIdentifier = "search_view"
    }
    
}

extension SearchView {
    
    func setupViewModel() {
        self.viewModel = SearchViewModel(
            norrisRepository: self.norrisRepository,
            localStorage: self.localStorage)
    }
    
    func setupBindings() {
        self.viewModel.categories
            .drive(self.categoriesCloudView.rx.items)
            .disposed(by: rx.disposeBag)
        
        self.categorySelected = self.categoriesCloudView.rx.tagSelected
        
        self.recentSearchSelected = self.recentSearchCloudView.rx.tagSelected
        
        self.viewModel.recentSearch
            .drive(self.recentSearchCloudView.rx.items)
            .disposed(by: rx.disposeBag)
        
        self.viewModel.isLoading
            .map { !$0 }
            .drive(self.activityIndicator.rx.isHidden)
            .disposed(by: rx.disposeBag)
        
        self.viewModel.isLoading
            .drive(self.activityIndicator.rx.isAnimating)
            .disposed(by: rx.disposeBag)
    }
}

//Animations
extension SearchView {
    func showAnimated() {
        self.recentSearchCloudView.alpha = 0.0
        self.categoriesCloudView.alpha = 0.0
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
            self.categoriesCloudView.alpha = 1.0
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveEaseOut, animations: {
            self.recentSearchCloudView.alpha = 1.0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
