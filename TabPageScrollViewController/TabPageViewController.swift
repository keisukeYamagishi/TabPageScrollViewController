//
//  RootViewController.swift
//  FunRecipes
//
//  Created by Shichimitoucarashi on 12/26/18.
//  Copyright © 2018 Shichimitoucarashi. All rights reserved.
//

import UIKit

public protocol TabPageDelegate {
    func willScrollPage(index: Int,viewController: UIViewController)
    func didScrollPage(index: Int,viewController: UIViewController)
    func tabChangeNotify(index: IndexPath, vc: UIViewController)
    func moveNavigationNotify(index: IndexPath)
}

@available(iOS 11.0, *)
open class TabPageScrollViewController: UIViewController {
    
    public var tabItems: [TabItem] = []
    public var delegate: TabPageDelegate?
    public var observer: TabPageObserver = TabPageObserver()
    var headerView: UIView!
    var pageView: UIView!
    private var barItem: UIBarButtonItem!
    private var isUp = false
    private var titles: [String] = []
    private var vcs: [UIViewController] = []
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        let filtering = Filtering(items: self.tabItems)
        
        self.headerView = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: self.view.frame.size.width,
                                               height: 30))
        
        self.pageView = UIView(frame: CGRect(x: 0,
                                             y: 0,
                                             width: self.view.frame.size.width,
                                             height: (self.view.frame.size.height - self.headerView.frame.size.height)))
        
        self.view.addSubview(self.pageView)
        self.view.addSubview(self.headerView)
        
        self.titles = filtering.titles
        self.vcs = filtering.viewControllers
        self.observer.delegate = self
        self.observer.viewControllers = filtering.viewControllers
        self.setChildViewController()
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.headerView.frame.origin.y = self.view.safeAreaInsets.top
        self.pageView.frame.origin.y = self.headerView.frame.origin.y + self.headerView.frame.size.height
    }
    
    private func setChildViewController () {
        
        self.addContainer(viewController: self.categoryViewController, containerView: self.headerView)
        self.addContainer(viewController: self.rootPageViewController, containerView: self.pageView)                
    }
    
    private func addContainer (viewController: UIViewController, containerView: UIView) {
        self.addChild(viewController)
        viewController.view.frame = containerView.frame
        viewController.view.frame = CGRect(x: 0, y: 0, width: viewController.view.frame.size.width, height: viewController.view.frame.size.height)
        containerView.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    private var rootPageViewController: PageViewController {
        let rootPageViewController = PageViewController()
        rootPageViewController.observer = self.observer
        rootPageViewController.vcs = self.vcs
        return rootPageViewController
    }
    
    private var categoryViewController: CategoryCollectionViewController {
        let categoryViewController = CategoryCollectionViewController()
        categoryViewController.observer = self.observer
        categoryViewController.observer = self.observer
        categoryViewController.items = self.titles
        return categoryViewController
    }
}

@available(iOS 11.0, *)
extension TabPageScrollViewController:TabPageControllerDelegate {
    
    func willScrollPageViewController(index: Int, viewController: UIViewController) {
        self.delegate?.willScrollPage(index: index, viewController: viewController)
    }
    
    func didScrollPageViewController(index: Int, viewController: UIViewController) {
        self.delegate?.didScrollPage(index: index, viewController: viewController)
    }
    
    func tabChange(index: IndexPath, viewController: UIViewController) {
        self.delegate?.tabChangeNotify(index: index, vc: viewController)
    }
    
    func moveNavigationView(index: IndexPath) {
        self.delegate?.moveNavigationNotify(index: index)
    }        
}
