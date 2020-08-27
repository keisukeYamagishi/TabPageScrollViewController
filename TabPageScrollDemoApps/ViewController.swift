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

        view.backgroundColor = color(num: number)
    }

    private func color(num: Int) -> UIColor {
        switch num {
        case 0:
            return .white
        case 1:
            return .gray
        case 2:
            return .darkGray
        case 3:
            return .cyan
        case 4:
            return .blue
        case 5:
            return .yellow
        case 6:
            return .magenta
        case 7:
            return .orange
        case 8:
            return .purple
        case 9:
            return .brown
        case 10:
            return .red
        default:
            return .green
        }
    }
}
