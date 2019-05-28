//
//  CategoryCell.swift
//  FunRecipes
//
//  Created by Shichimitoucarashi on 12/26/18.
//  Copyright © 2018 Shichimitoucarashi. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!

    func setTitle(_ title: String, strikethrough: Bool = false) {
        let attrStr = NSMutableAttributedString(string: title)
        attrStr.addAttributes([
            .foregroundColor: R.color.primaryText()?.withAlphaComponent(strikethrough ? 0.2 : 1) as Any,
            .strikethroughStyle: strikethrough ? 1 : 0
            ], range: NSRange(location: 0, length: title.count))

        UIView.performWithoutAnimation {
            self.title.attributedText = attrStr
            layoutIfNeeded()
        }
    }
}
