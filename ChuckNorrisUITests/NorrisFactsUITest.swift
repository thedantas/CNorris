//
//  NorrisFactsUITest.swift
//  ChuckNorrisUITests
//
//  Created by Andre Costa Dantas on 02/12/19.
//  Copyright © 2019 André  Costa Dantas. All rights reserved.
//

import Foundation
import Swinject
import UIKit
import KIF

@testable import ChuckNorris

class NorrisFactsUITest: KIFTestCase {
    
    let defaultContainer = DefaultContainer()
    var window: UIWindow!
    var coordinator: AppCoordinator?
    
    override func beforeEach() {
        
        self.configureContainer(container: self.defaultContainer.container)
        
        self.window = UIApplication.shared.keyWindow!
        
        self.coordinator = AppCoordinator(window: window, container: self.defaultContainer.container)
        
        coordinator?.start()
    }
    
    func configureContainer(container: Container) {
        fatalError("mockContainer must be overritten")
    }
    
}
extension NorrisFactsUITest {
    
    func expectToSee(_ msg: String) {
        tester().waitForView(withAccessibilityIdentifier: msg)
    }
    
    func expectNotToSee(_ msg: String) {
        tester().waitForAbsenceOfView(withAccessibilityIdentifier: msg)
    }
    
    func tapOnView(_ idString: String) {
        tester().tapView(withAccessibilityIdentifier: idString)
    }

    func getView(_ msg: String) -> UIView {
        return tester().waitForView(withAccessibilityLabel: msg)
    }
    
    func insertText(_ msg: String, intoView view: String) {
        tester().enterText(msg, intoViewWithAccessibilityIdentifier: view)
    }
}
