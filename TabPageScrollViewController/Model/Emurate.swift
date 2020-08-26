//
//  Emurate.swift
//  FunRecipes
//
//  Created by Shichimitoucarashi on 1/3/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import UIKit

struct Cell {
    var index: Int = 0
    var frame: CGRect = .zero

    init(frame: CGRect, index: Int) {
        self.frame = frame
        self.index = index
    }
}

class Emurate {
    var items: [String] = []
    var allCells: Int = 0

    init(items: [String]) {
        self.items = items
    }

    func frames(font: UIFont = UIFont.systemFont(ofSize: 20)) -> [CGRect] {
        var totalWidth: CGFloat = 0
        var frames: [CGRect] = []
        for title in items {
            let label = UILabel(frame: CGRect(x: totalWidth, y: 0, width: 100, height: 38))
            label.text = title
            label.font = font
            label.sizeToFit()
            label.frame.size.width += 20
            frames.append(label.frame)
            totalWidth += label.frame.size.width
        }
        return frames
    }
}
