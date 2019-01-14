//
//  Observer.swift
//  FunRecipes
//
//  Created by Shichimitoucarashi on 12/26/18.
//  Copyright © 2018 Shichimitoucarashi. All rights reserved.
//

import Foundation
import UIKit

enum Sort:Int {
    case up = 0
    case down = 1
}

protocol TabPageObserver {
    func navigationViewObserver(direction: Direction)
}

protocol TabChangeNotify {
    func changeTagNotify(index:IndexPath)
}

protocol TabPageControllerDelegate {
    func tabChange(index:IndexPath, viewController:UIViewController)
    func moveNavigationView(index:IndexPath, vc:UIViewController)
}

class Observer {
    
    var viewControllers:[UIViewController] = []
    var isFromNotify:Bool = false
    var selected:Int = 0
    var navigationObserver: TabPageObserver?
    var tabBarNotify:TabChangeNotify?
    var delegate:TabPageControllerDelegate?
    
    init(){}
    
    func movePosition (direction: Direction) {
        self.navigationObserver?.navigationViewObserver(direction: direction)
    }
    
    func tabNotify (index:IndexPath) {
        self.tabBarNotify?.changeTagNotify(index: index)
    }
    
    func tabCangeNotfy(index:Int) {
        self.delegate?.tabChange(index: IndexPath(row: index, section: 0), viewController: self.viewControllers[index])
    }
    
    func moveNavigationNotify(index:Int) {
        self.delegate?.moveNavigationView(index: IndexPath(row: index, section: 0), vc: self.viewControllers[index])
    }

}
