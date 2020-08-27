//
//  Emurate.swift
//  FunRecipes
//
//  Created by Shichimitoucarashi on 1/3/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import UIKit

class Emurate {
    var items: [String] = []
    let height: CGFloat
    let margin: CGFloat

    init(items: [String],
         height: CGFloat,
         margin: CGFloat = 20)
    {
        self.items = items
        self.height = height
        self.margin = margin
    }

    static func frames(with items: [String],
                       height: CGFloat,
                       font: UIFont = UIFont.systemFont(ofSize: 20)) -> [CGRect]
    {
        return Emurate(items: items, height: height).frames(font: font)
    }

    func frames(font: UIFont = UIFont.systemFont(ofSize: 20)) -> [CGRect] {
        var totalWidth: CGFloat = 0
        var frames: [CGRect] = []
        for title in items {
            let frame = CGRect(
                x: totalWidth,
                y: 0,
                width: title.toSize(with: font).width + margin,
                height: height
            )
            frames.append(frame)
            totalWidth += frame.size.width
        }
        return frames
    }
}
