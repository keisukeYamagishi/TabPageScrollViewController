//
//  RootPageViewController.swift
//  FunRecipes
//
//  Created by Shichimitoucarashi on 12/26/18.
//  Copyright © 2018 Shichimitoucarashi. All rights reserved.
//

import UIKit
import SHColor

class PageViewController:UIPageViewController {
    
    static let identifer = "PageViewController"
    var vcs:[UIViewController] = []
    var observer:Observer!
    var current:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        self.setScrollView()
        
        self.observer.tabBarNotify = self
        
        super.setViewControllers([self.vcs[0]], direction: .forward, animated: true, completion: nil)
    }
    
    private func setScrollView () {
        let scrollView = view.subviews.compactMap { $0 as? UIScrollView }.first
        scrollView?.scrollsToTop = false
        scrollView?.delegate = self
    }
}

extension PageViewController : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        self.current += 1
        
        print (self.current)
        
        if self.current > (self.vcs.count - 1) {
            self.current = (self.vcs.count - 1)
            return nil
        }else{
            return self.vcs[self.current]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        self.current -= 1
        
        print (self.current)
        
        if self.current < 0 {
            self.current = 0
            return nil
        }else{
            return self.vcs[self.current]
        }
    }
}

extension PageViewController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let scrollOffsetX = scrollView.contentOffset.x - view.frame.width
        
        if scrollOffsetX >= self.view.frame.size.width {
            self.observer.movePosition(direction: .right)
        }
        
        if scrollOffsetX < 0 && scrollOffsetX <= (self.view.frame.size.width * -1) {
            self.observer.movePosition(direction: .left)
        }
    }
}

extension PageViewController:TabChangeNotify{
    
    func changeTagNotify(index: IndexPath) {
        if index.row != self.observer.selected {
            
            self.observer.isFromNotify = true
            
            let direction:NavigationDirection!
            
            if index.row > self.observer.selected {
                direction = .forward
            }else{
                direction = .reverse
            }
            
            self.observer.tabCangeNotfy(index: index.row)
            
            super.setViewControllers([self.vcs[index.row]], direction: direction, animated: true, completion: nil)
        }
    }
}
