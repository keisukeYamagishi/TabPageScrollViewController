//
//  CategoryCollectionViewController.swift
//  FunRecipes
//
//  Created by Shichimitoucarashi on 12/26/18.
//  Copyright © 2018 Shichimitoucarashi. All rights reserved.
//

import UIKit
import SHColor

class CategoryCollectionViewController:UIViewController{
    
    var collectionView:UICollectionView!
    var navigationView: UIView!
    
    static let identifer = "CategoryCollectionViewController"
    
    public var items:[String] = []
    private var emurate:Emurate!
    var observer:Observer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView = self.coll
        
        self.navigationView = self.navi
        
        self.view.addSubview(self.collectionView)
        
        self.view.addSubview(self.navigationView)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.setScrollView()
        
        self.observer.navigationObserver = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            
        self.setCellsPosition()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        self.setCellsPosition()
        
    }
    
    private var coll: UICollectionView {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 23), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        return collectionView
    }
    
    private var navi: UIView {
        let view = UIView(frame: CGRect(x: 0, y: 26, width: 124, height: 3))
        view.backgroundColor = .black
        return view
    }
    
    private func setScrollView (){
        let scrollView = collectionView.subviews.compactMap { $0 as? UIScrollView }.first
        scrollView?.scrollsToTop = false
        scrollView?.delegate = self
    }
    
    private func setCellsPosition () {
        let cells:[CategoryCell] = self.collectionView.visibleCells as! [CategoryCell]
        self.emurate = Emurate(cells: cells,cellsCount: self.items.count)
        self.moveNavigationView(index: 0)
    }
    
    private func moveNavigationView(index:Int) {
        let frame = self.emurate.cellFrame(index: index)
        self.collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            self.navigationView.frame = CGRect(x: frame.origin.x - self.collectionView.contentOffset.x,
                                               y: self.navigationView.frame.origin.y,
                                               width: frame.size.width,
                                               height: self.navigationView.frame.size.height)
        }, completion: nil)
    }
}

extension CategoryCollectionViewController:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize: CGFloat = self.view.frame.size.width/5 - 1
        return CGSize(width: cellSize, height: 23)
    }
}

extension CategoryCollectionViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:CategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategoryCell
        
        cell.title.text = self.items[indexPath.row]
        cell.tag = indexPath.row
        
        if self.observer.selected == indexPath.row {
            cell.title.textColor = .blue
        }else{
            cell.title.textColor = .lightGray
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.observer.tabNotify(index: indexPath)
        self.observer.selected = indexPath.row
        self.moveNavigationView(index: indexPath.row)
        self.collectionView.reloadData()
    }
}

extension CategoryCollectionViewController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let scrollOffsetX = scrollView.contentOffset.x
        
        if let emurate = self.emurate {
            let frame = emurate.cellFrame(index: self.observer.selected)
            self.navigationView.frame = CGRect(x: frame.origin.x,
                                               y: self.navigationView.frame.origin.y,
                                               width: frame.size.width,
                                               height: self.navigationView.frame.size.height)
            self.navigationView.frame.origin.x = (scrollOffsetX * -1) + frame.origin.x
        }
        
//        let frame = self.emurate.cellFrame(index: self.observer.selected)
//        self.navigationView.frame = CGRect(x: frame.origin.x,
//                                           y: self.navigationView.frame.origin.y,
//                                           width: frame.size.width,
//                                           height: self.navigationView.frame.size.height)
//        self.navigationView.frame.origin.x = (scrollOffsetX * -1) + frame.origin.x
        
    }
}

extension CategoryCollectionViewController:TaObserver{
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
