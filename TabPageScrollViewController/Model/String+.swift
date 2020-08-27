//
//  String+.swift
//  TabPageScrollViewController
//
//  Created by keisuke yamagishi on 2020/08/27.
//  Copyright © 2020 Shichimitoucarashi. All rights reserved.
//

import Foundation

internal extension String {
    func toSize(with font: UIFont) -> CGSize {
        return self.size(withAttributes: [NSAttributedString.Key.font: font])
    }
}
