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
    public var navigationView: UIView!
    public var items: [String] = []
    var observer: TabPageObserver!
    var isTapCell: Bool = false
    var frames: [CGRect] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setCollectionView()
        observer.scrollObserver = self
        setScrollView()
        observer.navigationObserver = self

        frames = Emurate(items: items).frames()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setCellsPosition()
    }

    private func setCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 23), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.register(UINib(nibName: "CategoryCell", bundle: Bundle(for: type(of: self))), forCellWithReuseIdentifier: "Cell")
        view.addSubview(collectionView)
    }

    private func setNavigation() {
        navigationView = UIView(frame: CGRect(x: 0, y: 26, width: 124, height: 3))
        navigationView.backgroundColor = .black
        view.addSubview(navigationView)
    }

    private func setScrollView() {
        let scrollView = collectionView.subviews.compactMap { $0 as? UIScrollView }.first
        scrollView?.scrollsToTop = false
        scrollView?.delegate = self
    }

    private func setCellsPosition() {
        moveNavigationView(index: 0)
    }

    private func moveNavigationView(index: Int) {
        let frame = frames[index]
        collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationView.frame = CGRect(x: frame.origin.x - self.collectionView.contentOffset.x,
                                               y: self.navigationView.frame.origin.y,
                                               width: frame.size.width,
                                               height: self.navigationView.frame.size.height)
        }) { [weak self] _ in
            self?.isTapCell = false
        }
    }
}

extension CategoryCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView,
                        layout _: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if !items.isEmpty {
            return frames[indexPath.row].size
        }

        let cellSize: CGFloat = view.frame.size.width / 5 - 1
        return CGSize(width: cellSize, height: 23)
    }
}

extension CategoryCollectionViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategoryCell

        cell.title.text = items[indexPath.row]
        cell.tag = indexPath.row

        if observer.selected == indexPath.row {
            cell.title.textColor = UIColor(red: 69 / 255, green: 134 / 255, blue: 255 / 255, alpha: 1.0)
        } else {
            cell.title.textColor = .lightGray
        }
        return cell
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        observer.tabNotify(index: indexPath)
        observer.selected = indexPath.row
        isTapCell = true
        moveNavigationView(index: indexPath.row)
        collectionView.reloadData()
    }
}

extension CategoryCollectionViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollOffsetX = scrollView.contentOffset.x

        let frame = frames[observer.selected]
        navigationView.frame = CGRect(x: frame.origin.x,
                                      y: navigationView.frame.origin.y,
                                      width: frame.size.width,
                                      height: navigationView.frame.size.height)
        navigationView.frame.origin.x = (scrollOffsetX * -1) + frame.origin.x
    }
}

extension CategoryCollectionViewController: TabObserver {
    func navigationViewObserver(index: Int) {
        observer.selected = index

        if observer.selected < 0 {
            observer.selected = 0
        } else if observer.selected > (items.count - 1) {
            observer.selected = items.count - 1
        }

        observer.moveNavigationNotify(index: observer.selected)

        moveNavigationView(index: observer.selected)
        collectionView.reloadData()
    }
}

extension CategoryCollectionViewController: PageViewObserver {
    func pageBeginDraging(contentOffset _: CGPoint) {}

    func pageViewObserer(contentOffSet: CGPoint) {
        guard !isTapCell else {
            return
        }

        let movedPoint = contentOffSet.x - view.bounds.size.width

        let scrolRate = movedPoint * (navigationView.frame.size.width / view.frame.size.width)

        let frame = frames[observer.selected]
        navigationView.frame.origin.x = scrolRate + (frame.origin.x - collectionView.contentOffset.x)
    }
}
