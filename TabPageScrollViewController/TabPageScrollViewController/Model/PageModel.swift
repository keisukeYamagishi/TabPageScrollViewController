//
//  File.swift
//  FunRecipes
//
//  Created by Shichimitoucarashi on 1/12/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import Foundation
import UIKit

enum Direction:Int {
    case left = -1
    case right = 1
}

struct TabItem {
    var title:String = ""
    var viewController:UIViewController!
    init(title:String,vc:UIViewController) {
        self.title = title
        self.viewController = vc
    }
}
