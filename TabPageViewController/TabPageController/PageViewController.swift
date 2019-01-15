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
    
    
    func pageViewController(viewController:UIViewController, isAfter:Bool) -> UIViewController? {
        
        guard var index = self.vcs.map({$0}).index(of: viewController) else {
            return nil
        }
        
        if isAfter {
            index += 1
        }else{
            index -= 1
        }
        
        if index >= 0 && index < self.vcs.count {
            return self.vcs[index]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return self.pageViewController(viewController: viewController, isAfter: true)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {        
        return self.pageViewController(viewController: viewController, isAfter: false)
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
