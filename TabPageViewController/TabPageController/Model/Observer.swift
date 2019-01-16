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

protocol TaObserver {
    func navigationViewObserver(index:Int)
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
    var selected:Int = 0
    var navigationObserver: TaObserver?
    var tabBarNotify:TabChangeNotify?
    var delegate:TabPageControllerDelegate?
    
    init(){}
    
    func movePosition (index:Int) {
        self.navigationObserver?.navigationViewObserver(index: index)
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
