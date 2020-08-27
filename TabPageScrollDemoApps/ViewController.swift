//
//  RecipesCollectionViewController.swift
//  FunRecipes
//
//  Created by Shichimitoucarashi on 12/26/18.
//  Copyright © 2018 Shichimitoucarashi. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    static let identifer = "ViewController"

    @IBOutlet var label: UILabel!

    var number: Int = 0

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.text = number.description
    }
}
