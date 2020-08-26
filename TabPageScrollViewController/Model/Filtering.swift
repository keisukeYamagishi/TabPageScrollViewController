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
        split(items: items)
    }

    func split(items: [TabItem]) {
        for item in items {
            viewControllers.append(item.viewController)
            titles.append(item.title)
        }
    }
}
