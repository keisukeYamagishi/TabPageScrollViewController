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
    
    var cells:[Cell] = []
    var allCells: Int = 0
    
    init(cellFrame: CGRect, cellsCount: Int) {
        
        
        for index in 0..<cellsCount {
            self.cells.append(Cell(frame: CGRect(x: cellFrame.size.width * CGFloat(index),
                                                 y: cellFrame.origin.y,
                                                 width: cellFrame.size.width,
                                                 height: cellFrame.size.height), index: index))
        }
    }
    
    func cellFrame(index:Int) -> CGRect {
        for cell in self.cells where cell.index == index {
            return cell.frame
        }
        return .zero
    }
}
