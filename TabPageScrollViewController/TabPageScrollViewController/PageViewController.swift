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
    
    var currentIndex: Int? {
        guard let viewController = viewControllers?.first else {
            return nil
        }
        return self.vcs.map{ $0 }.index(of: viewController)
    }
    
    var beforeIndex:Int = 0
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        self.setScrollView()
        
        self.observer.tabBarNotify = self
        
        super.setViewControllers([self.vcs[0]],
                                 direction: .forward,
                                 animated: true,
                                 completion: nil)
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

extension PageViewController:UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            willTransitionTo pendingViewControllers: [UIViewController]){}
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool){
        
        self.observer.movePosition(index: currentIndex!)
    }
}

extension PageViewController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {}
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {}
}

extension PageViewController:TabChangeNotify{
    
    func changeTagNotify(index: IndexPath) {
        if index.row != self.observer.selected {
            
            let direction:NavigationDirection!
            
            if index.row > self.observer.selected {
                direction = .forward
            }else{
                direction = .reverse
            }
            
            self.observer.tabCangeNotfy(index: index.row)
            
            super.setViewControllers([self.vcs[index.row]],
                                     direction: direction,
                                     animated: true,
                                     completion: nil)
        }
    }
}
