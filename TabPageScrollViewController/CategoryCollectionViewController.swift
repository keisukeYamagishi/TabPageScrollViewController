//
//  CategoryCollectionViewController.swift
//  FunRecipes
//
//  Created by Shichimitoucarashi on 12/26/18.
//  Copyright © 2018 Shichimitoucarashi. All rights reserved.
//

import UIKit

class CategoryCollectionViewController: UIViewController{
    
    var collectionView: UICollectionView!
    public var navigationView: UIView!
    public var items: [String] = []
    var observer: TabPageObserver!
    var isTapCell: Bool = false
    var frames: [CGRect] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigation()
        self.setCollectionView()
        self.observer.scrollObserver = self        
        self.setScrollView()
        self.observer.navigationObserver = self
        
        self.frames = Emurate(items: self.items).frames()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setCellsPosition()
    }
    
    private func setCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 23), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(UINib(nibName: "CategoryCell", bundle: Bundle(for: type(of: self))), forCellWithReuseIdentifier: "Cell")
        self.view.addSubview(self.collectionView)
    }
    
    private func setNavigation() {
        self.navigationView = UIView(frame: CGRect(x: 0, y: 26, width: 124, height: 3))
        self.navigationView.backgroundColor = .black
        self.view.addSubview(self.navigationView)
    }
    
    private func setScrollView (){
        let scrollView = collectionView.subviews.compactMap { $0 as? UIScrollView }.first
        scrollView?.scrollsToTop = false
        scrollView?.delegate = self
    }
    
    private func setCellsPosition () {
        self.moveNavigationView(index: 0)
    }

    private func moveNavigationView(index: Int) {
        let frame = self.frames[index]
        self.collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationView.frame = CGRect(x: frame.origin.x - self.collectionView.contentOffset.x,
                                               y: self.navigationView.frame.origin.y,
                                               width: frame.size.width,
                                               height: self.navigationView.frame.size.height)
        }) { [weak self] (flg) in
            self?.isTapCell = false
        }
    }
}

extension CategoryCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if !self.items.isEmpty {
            return self.frames[indexPath.row].size
        }
        
        let cellSize: CGFloat = self.view.frame.size.width/5 - 1
        return CGSize(width: cellSize, height: 23)
    }
}

extension CategoryCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:CategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategoryCell
        
        cell.title.text = self.items[indexPath.row]
        cell.tag = indexPath.row
        
        if self.observer.selected == indexPath.row {
            cell.title.textColor = UIColor(red: 69 / 255, green: 134 / 255, blue: 255 / 255, alpha: 1.0)
        }else{
            cell.title.textColor = .lightGray
        }
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

extension CategoryCollectionViewController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let scrollOffsetX = scrollView.contentOffset.x
        
        let frame = self.frames[self.observer.selected]
        self.navigationView.frame = CGRect(x: frame.origin.x,
                                           y: self.navigationView.frame.origin.y,
                                           width: frame.size.width,
                                           height: self.navigationView.frame.size.height)
        self.navigationView.frame.origin.x = (scrollOffsetX * -1) + frame.origin.x
        
    }
}

extension CategoryCollectionViewController: TabObserver{
    func navigationViewObserver(index: Int) {
        self.observer.selected = index
        
        if self.observer.selected < 0 {
            self.observer.selected = 0
        }else if self.observer.selected > (self.items.count - 1){
            self.observer.selected = self.items.count - 1
        }
        
        self.observer.moveNavigationNotify(index: self.observer.selected)
        
        self.moveNavigationView(index: self.observer.selected)
        self.collectionView.reloadData()
    }
}

extension CategoryCollectionViewController: PageViewObserver {
    
    func pageBeginDraging(contentOffset: CGPoint) {}
    
    func pageViewObserer(contentOffSet: CGPoint) {
        
        guard !self.isTapCell else {
            return
        }
        
        let movedPoint = contentOffSet.x - self.view.bounds.size.width
        
        let scrolRate = movedPoint * (self.navigationView.frame.size.width / self.view.frame.size.width)
        
        let frame = self.frames[self.observer.selected]
        self.navigationView.frame.origin.x = scrolRate + (frame.origin.x - self.collectionView.contentOffset.x)
    }
}
