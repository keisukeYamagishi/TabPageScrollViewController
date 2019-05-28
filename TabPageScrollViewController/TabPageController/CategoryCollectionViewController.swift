//
//  CategoryCollectionViewController.swift
//  FunRecipes
//
//  Created by Shichimitoucarashi on 12/26/18.
//  Copyright © 2018 Shichimitoucarashi. All rights reserved.
//

import UIKit

class CategoryCollectionViewController: UIViewController {

    var collectionView: UICollectionView!
    public var items: [String] = []
    public var emurate: Emurate!
    var observer: TabPageObserver!
    var isTapCell: Bool = false
    var isScrollableEnable: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCollectionView()
        self.observer.navigationObserver = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView.isScrollEnabled = self.isScrollableEnable
        self.setCellsPosition()
    }

    private func setCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        self.collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 38), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        collectionView.register(R.nib.categoryCell)
        self.view.addSubview(self.collectionView)
    }

    private func setCellsPosition () {
        self.emurate = Emurate(self.collectionView.visibleCells, count: self.items.count)
        self.moveNavigationView(index: 0)
    }

    private func moveNavigationView(index: Int) {
        self.collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
    }
}

extension CategoryCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize: CGFloat = self.view.frame.size.width/3 - 1
        return CGSize(width: cellSize, height: 38)
    }
}

extension CategoryCollectionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: CategoryCell = (collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CategoryCell)!

        cell.title.text = self.items[indexPath.row]
        cell.tag = indexPath.row
        cell.setTitle(self.items[indexPath.row], strikethrough: indexPath.row == self.observer.selected)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.observer.tabNotify(index: indexPath)
        self.observer.selected = indexPath.row
        self.isTapCell = true
        self.moveNavigationView(index: indexPath.row)
        self.collectionView.reloadData()
    }
}

extension CategoryCollectionViewController: TaObserver {
    func navigationViewObserver(index: Int) {
        self.observer.selected = index
        if self.observer.selected < 0 {
            self.observer.selected = 0
        } else if self.observer.selected > (self.items.count - 1) {
            self.observer.selected = self.items.count - 1
        }
        self.observer.moveNavigationNotify(index: self.observer.selected)
        self.moveNavigationView(index: self.observer.selected)
        self.collectionView.reloadData()
    }
}
