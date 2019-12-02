//
//  FactCell.swift
//  ChuckNorris
//
//  Created by André  Costa Dantas on 01/12/19.
//  Copyright © 2019 André  Costa Dantas. All rights reserved.
//

import Foundation
import Reusable

protocol FactCellDelegate: class {
    func share(image: UIImage?)
}

class FactCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var categoriesCloudView: CategoriesTagView!
    
    weak var delegate: FactCellDelegate?
    
    var viewModel = FactItemViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupBindings()
        self.backgroundColor = .clear
        self.categoriesCloudView.configure(tagHeight: 32.0,
                                           tagBackgroundColor: UIColor.white.withAlphaComponent(0.2),
                                           textColor: UIColor.white)
    }
    
    func bind(_ fact: Fact) {
        self.viewModel.bind(fact)
    }
    
    func setupBindings() {
        self.viewModel.text
            .drive(factLabel.rx.text)
            .disposed(by: rx.disposeBag)
        
        self.viewModel.backgroundImage
            .drive(backgroundImage.rx.image)
            .disposed(by: rx.disposeBag)

        self.viewModel.fontSize
            .drive(factLabel.rx.fontSize)
            .disposed(by: rx.disposeBag)
        
        self.shareButton.rx.tap.bind { [weak self] in
            let image = self?.imageView?.image
            self?.delegate?.share(image: image)
        }.disposed(by: rx.disposeBag)
        
        self.viewModel.categories
            .drive(categoriesCloudView.rx.items)
            .disposed(by: rx.disposeBag)
        
    }
}
