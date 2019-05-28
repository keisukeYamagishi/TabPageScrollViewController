//
//  Emurate.swift
//  FunRecipes
//
//  Created by Shichimitoucarashi on 1/3/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import UIKit

struct Cell {
    var tag: Int = 0
    var originX: CGFloat
    init(tag: Int, originX: CGFloat) {
        self.tag = tag
        self.originX = originX
    }
}

class Emurate {

    var cells: [Cell] = []
    init(_ collectionViewCells: [UICollectionViewCell], count: Int) {

        let frame = collectionViewCells.first?.frame

        for index in 0..<count {
            self.cells.append(Cell(tag: index, originX: (frame?.origin.x)! * CGFloat(index)))
        }
    }

    func originX(index: Int) -> CGFloat {
        for cell in self.cells where cell.tag == index {
            return cell.originX
        }
        return 0
    }
}
