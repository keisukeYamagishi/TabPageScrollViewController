//
//  RootViewController.swift
//  FunRecipes
//
//  Created by Shichimitoucarashi on 12/26/18.
//  Copyright © 2018 Shichimitoucarashi. All rights reserved.
//

import UIKit

protocol TabPageDelegate {
    func tabChangeNotify(index:IndexPath, vc:UIViewController)
    func moveNavigationNotify(index:IndexPath, vc:UIViewController)
}

class TabPageScrollViewController: UIViewController {
    
    @IBOutlet weak var headerView:UIView!
    @IBOutlet weak var pageView:UIView!
    
    public var tabItems:[TabItem] = []
    
    public var delegate:TabPageDelegate?
    
    public var observer:Observer = Observer()
    
    private var barItem:UIBarButtonItem!
    private var isUp = false
    private var titles:[String] = []
    private var vcs:[UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filtering = Filtering(items: self.tabItems)
        
        self.titles = filtering.titles
        self.vcs = filtering.viewControllers
        self.observer.delegate = self
        self.observer.viewControllers = filtering.viewControllers
        self.setChildViewController()
    }
    
    private func setChildViewController () {
        self.addContainer(viewController: self.categoryViewController, containerView: self.headerView)
        self.pageView.frame = CGRect(x: 0, y: 0, width: self.pageView.frame.size.width, height: self.pageView.frame.size.height)
        self.addContainer(viewController: self.rootPageViewController, containerView: self.pageView)
    }
    
    private func addContainer (viewController:UIViewController, containerView:UIView ) {
        self.addChild(viewController)
        viewController.view.frame = containerView.frame
        containerView.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    private var rootPageViewController:PageViewController {
        let rootPageViewController = self.storyboard?.instantiateViewController(withIdentifier: PageViewController.identifer) as! PageViewController
        rootPageViewController.observer = self.observer
        rootPageViewController.vcs = self.vcs
        return rootPageViewController
    }
    
    private var categoryViewController:CategoryCollectionViewController {
        let categoryViewController = self.storyboard?.instantiateViewController(withIdentifier: CategoryCollectionViewController.identifer) as! CategoryCollectionViewController
        categoryViewController.observer = self.observer
        categoryViewController.items = self.titles
        return categoryViewController
    }
}

extension TabPageScrollViewController:TabPageControllerDelegate {
    func tabChange(index: IndexPath, viewController: UIViewController) {
        self.delegate?.tabChangeNotify(index: index, vc: viewController)
    }
    
    func moveNavigationView(index: IndexPath, vc: UIViewController) {
        self.delegate?.moveNavigationNotify(index: index, vc: vc)
    }        
}
