//
//  Emurate.swift
//  FunRecipes
//
//  Created by Shichimitoucarashi on 1/3/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import UIKit

struct Cell {
    let index: Int
    let frame: CGRect
}

class Emurate {
    var items: [String] = []
    let height: CGFloat

    init(items: [String],
         height: CGFloat)
    {
        self.items = items
        self.height = height
    }

    static func frames(with items: [String],
                       height: CGFloat,
                       font: UIFont = UIFont.systemFont(ofSize: 20)) -> [CGRect]
    {
        Emurate(items: items, height: height).frames(font: font)
    }

    func frames(font: UIFont = UIFont.systemFont(ofSize: 20)) -> [CGRect] {
        var totalWidth: CGFloat = 0
        var frames: [CGRect] = []
        for title in items {
            let frame = CGRect(
                x: totalWidth,
                y: 0,
                width: title.size(with: font).width + 20,
                height: height
            )
            frames.append(frame)
            totalWidth += frame.size.width
        }
        return frames
    }
}

public extension String {
    func size(with font: UIFont) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        return size(withAttributes: attributes)
    }
}
