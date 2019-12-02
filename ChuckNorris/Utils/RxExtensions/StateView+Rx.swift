//
//  StateView+Rx.swift
//  ChuckNorris
//
//  Created by André  Costa Dantas on 01/12/19.
//  Copyright © 2019 André  Costa Dantas. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

extension Reactive where Base: StateView {
    
    var state: Binder<ViewState> {
        return Binder(self.base) { stateView, state in
            stateView.state = state
        }
    }
    
}
