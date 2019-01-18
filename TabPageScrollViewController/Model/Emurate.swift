//
//  Emurate.swift
//  FunRecipes
//
//  Created by Shichimitoucarashi on 1/3/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import UIKit

class Emurate {
    
    var cells:[CategoryCell] = []
    var allCells: Int = 0
    
    init(cells:[CategoryCell], cellsCount: Int) {
        
        self.allCells = cellsCount
        
        if self.allCells > cells.count {
            
            let frame:CGRect = cells[1].frame
            
            for num in 0..<self.allCells {
                
                let cell:CategoryCell = CategoryCell()
                cell.tag = num
                let f = CGRect(x: frame.origin.x * CGFloat(num),
                               y: frame.origin.y,
                               width: frame.size.width,
                               height: frame.size.height)
                cell.frame = f
                self.cells.append(cell)
            }            
        }else{
            self.cells = cells
        }
    }
    
    func cellFrame(index:Int) -> CGRect {
        var frame = CGRect.zero
        for cell in self.cells {
            if cell.tag == index {
                frame = cell.frame
            }
        }
        return frame
    }
}
