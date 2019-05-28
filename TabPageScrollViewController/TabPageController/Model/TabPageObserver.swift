//
//  Observer.swift
//  FunRecipes
//
//  Created by Shichimitoucarashi on 12/26/18.
//  Copyright © 2018 Shichimitoucarashi. All rights reserved.
//

import Foundation
import UIKit

protocol TaObserver: class {
    func navigationViewObserver(index: Int)
}

protocol TabChangeNotify: class {
    func changeTagNotify(index: IndexPath)
}

protocol TabPageControllerDelegate: class {
    func willScrollPageViewController (index: Int, viewController: UIViewController)
    func didScrollPageViewController (index: Int, viewController: UIViewController)
    func tabChange(index: IndexPath, viewController: UIViewController)
    func moveNavigationView(index: IndexPath)
}

public class TabPageObserver {
    
    var viewControllers: [UIViewController] = []
    var selected: Int = 0
    weak var navigationObserver: TaObserver?
    weak var tabBarNotify: TabChangeNotify?
    weak var delegate: TabPageControllerDelegate?

    init() {}

    func movePosition (index: Int) {
        self.navigationObserver?.navigationViewObserver(index: index)
    }

    func tabNotify (index: IndexPath) {
        self.tabBarNotify?.changeTagNotify(index: index)
    }

    func willScrollViewController (index: Int, viewController: UIViewController) {
        self.delegate?.willScrollPageViewController(index: index, viewController: viewController)
    }

    func didScrollViewController (index: Int, viewController: UIViewController) {
        self.delegate?.didScrollPageViewController(index: index, viewController: viewController)
    }

    func tabCangeNotfy(index: Int, viewController: UIViewController) {
        self.delegate?.tabChange(index: IndexPath(row: index, section: 0), viewController: viewController)
    }

    func moveNavigationNotify(index: Int) {
        self.delegate?.moveNavigationView(index: IndexPath(row: index, section: 0))
    }

}
