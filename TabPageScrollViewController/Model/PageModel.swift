//
//  File.swift
//  FunRecipes
//
//  Created by Shichimitoucarashi on 1/12/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import Foundation
import UIKit

public struct TabItem {
    public var title:String = ""
    public var viewController:UIViewController!
    public init(title:String,vc:UIViewController) {
        self.title = title
        self.viewController = vc
    }
}
