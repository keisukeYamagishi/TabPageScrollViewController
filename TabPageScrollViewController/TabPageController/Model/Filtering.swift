//
//  Filtering.swift
//  TabPageScrollViewController
//
//  Created by Shichimitoucarashi on 1/13/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import Foundation
import UIKit

class Filtering {

    public var viewControllers: [UIViewController] = []
    public var titles: [String] = []

    init(items: [TabItem]) {
        self.split(items: items)
    }

    func split (items: [TabItem]) {
        for item in items {
            self.viewControllers.append(item.viewController)
            self.titles.append(item.title)
        }
    }
}
