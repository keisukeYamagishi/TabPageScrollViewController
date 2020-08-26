//
//  Observer.swift
//  FunRecipes
//
//  Created by Shichimitoucarashi on 12/26/18.
//  Copyright © 2018 Shichimitoucarashi. All rights reserved.
//

import Foundation
import UIKit

protocol TabObserver: class {
    func navigationViewObserver(index: Int)
}

protocol TabChangeNotify: class {
    func changeTagNotify(index: IndexPath)
}

protocol TabPageControllerDelegate: class {
    func willScrollPageViewController(index: Int, viewController: UIViewController)
    func didScrollPageViewController(index: Int, viewController: UIViewController)
    func tabChange(index: IndexPath, viewController: UIViewController)
    func moveNavigationView(index: IndexPath)
}

protocol PageViewObserver: class {
    func pageViewObserer(contentOffSet: CGPoint)
}

public class TabPageObserver {
    var viewControllers: [UIViewController] = []
    var selected: Int = 0
    weak var navigationObserver: TabObserver?
    weak var tabBarNotify: TabChangeNotify?
    weak var delegate: TabPageControllerDelegate?
    weak var scrollObserver: PageViewObserver?

    init() {}

    func pageScrollObserver(contetntOffset: CGPoint) {
        scrollObserver?.pageViewObserer(contentOffSet: contetntOffset)
    }

    func movePosition(index: Int) {
        navigationObserver?.navigationViewObserver(index: index)
    }

    func tabNotify(index: IndexPath) {
        tabBarNotify?.changeTagNotify(index: index)
    }

    func willScrollViewController(index: Int, viewController: UIViewController) {
        delegate?.willScrollPageViewController(index: index, viewController: viewController)
    }

    func didScrollViewController(index: Int, viewController: UIViewController) {
        delegate?.didScrollPageViewController(index: index, viewController: viewController)
    }

    func tabCangeNotfy(index: Int, viewController: UIViewController) {
        delegate?.tabChange(index: IndexPath(row: index, section: 0), viewController: viewController)
    }

    func moveNavigationNotify(index: Int) {
        delegate?.moveNavigationView(index: IndexPath(row: index, section: 0))
    }
}
