//
//  RecipesCollectionViewController.swift
//  FunRecipes
//
//  Created by Shichimitoucarashi on 12/26/18.
//  Copyright © 2018 Shichimitoucarashi. All rights reserved.
//

import UIKit

class DetailViewController:UIViewController{
    
    static let identifer = "DetailViewController"
    
    @IBOutlet weak var viewLabel: UILabel!
    var number: Int = 0
    
    override func viewDidLoad() {        
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.viewLabel.text = self.number.description
    }
}
