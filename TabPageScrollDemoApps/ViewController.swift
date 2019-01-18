//
//  RecipesCollectionViewController.swift
//  FunRecipes
//
//  Created by Shichimitoucarashi on 12/26/18.
//  Copyright © 2018 Shichimitoucarashi. All rights reserved.
//

import UIKit

class ViewController:UIViewController{
    
    static let identifer = "ViewController"
       
    @IBOutlet weak var label: UILabel!
    
    var number: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.label.text = self.number.description
        
        self.view.backgroundColor = self.color(num: self.number)
    }
    
    private func color (num:Int) -> UIColor {
        
        switch num {
        case 0:
            return UIColor(hex:"5fc9f8")
        case 1:
            return UIColor(hex:"fecb2e")
        case 2:
            return UIColor(hex:"fc3158")
        case 3:
            return UIColor(hex:"147efb")
        case 4:
            return UIColor(hex:"53d769")
        case 5:
            return UIColor(hex:"fc3d39")
        case 6:
            return UIColor(hex:"8e8e93")
        case 7:
            return UIColor(hex:"fc3158")
        case 8:
            return UIColor(hex:"53d769")
        case 9:
            return UIColor(hex: "#028482")
        case 10:
            return UIColor(hex: "#B76EB8")
        default:
            return UIColor(hex:"fc3158")
        }
    }
}
