//
//  RootViewController.swift
//  TabPageScrollViewController
//
//  Created by Shichimitoucarashi on 1/17/19.
//  Copyright © 2019 Shichimitoucarashi. All rights reserved.
//

import CoreML
import TabPageScrollViewController
import UIKit

@available(iOS 11.0, *)
final class RootViewControler: TabPageScrollViewController {
    override func viewDidLoad() {
        navigationController?.navigationBar.topItem?.title = "TabPage app demo"

        delegate = self

        let vc1: ViewController = storyboard!.instantiateViewController(withIdentifier: ViewController.identifer) as! ViewController
        vc1.number = 1
        let vc2: ViewController = storyboard!.instantiateViewController(withIdentifier: ViewController.identifer) as! ViewController
        vc2.number = 2
        let vc3: ViewController = storyboard!.instantiateViewController(withIdentifier: ViewController.identifer) as! ViewController
        vc3.number = 3
        let vc4: ViewController = storyboard!.instantiateViewController(withIdentifier: ViewController.identifer) as! ViewController
        vc4.number = 4
        let vc5: ViewController = storyboard!.instantiateViewController(withIdentifier: ViewController.identifer) as! ViewController
        vc5.number = 5
        let vc6: ViewController = storyboard!.instantiateViewController(withIdentifier: ViewController.identifer) as! ViewController
        vc6.number = 6
        let vc7: ViewController = storyboard!.instantiateViewController(withIdentifier: ViewController.identifer) as! ViewController
        vc7.number = 7
        let vc8: ViewController = storyboard!.instantiateViewController(withIdentifier: ViewController.identifer) as! ViewController
        vc8.number = 8
        let vc9: ViewController = storyboard!.instantiateViewController(withIdentifier: ViewController.identifer) as! ViewController
        vc9.number = 9
        let vc10: ViewController = storyboard!.instantiateViewController(withIdentifier: ViewController.identifer) as! ViewController
        vc10.number = 10
        let vc11: ViewController = storyboard!.instantiateViewController(withIdentifier: ViewController.identifer) as! ViewController
        vc11.number = 11

        tabItems = [TabItem(title: "UIKit", vc: vc1),
                    TabItem(title: "Foundation", vc: vc2),
                    TabItem(title: "Photos", vc: vc3),
                    TabItem(title: "ARKit", vc: vc4),
                    TabItem(title: "GameKit", vc: vc5),
                    TabItem(title: "RxAlert", vc: vc6),
                    TabItem(title: "CoreBluetooth", vc: vc7),
                    TabItem(title: "SQLite3", vc: vc8),
                    TabItem(title: "CoreML", vc: vc9),
                    TabItem(title: "RxSwift", vc: vc10),
                    TabItem(title: "xsort", vc: vc11)]

        view.backgroundColor = .white
        tabHeight = 50
        super.viewDidLoad()
        tabBackgroundColor = .black
        register(nibName: "CategoryCell", reuseIdentifier: "CategoryCell")
    }
}

@available(iOS 11.0, *)
extension RootViewControler: TabPageDelegate {

    func categoryView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, selected: Int) -> UICollectionViewCell {
        let cell: CategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell

        cell.title.text = tabItems[indexPath.row].title
        cell.tag = indexPath.row

        if selected == indexPath.row {
            cell.title.textColor = UIColor(red: 69 / 255, green: 134 / 255, blue: 255 / 255, alpha: 1.0)
        } else {
            cell.title.textColor = .lightGray
        }
        return cell
    }

    func categoryView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
