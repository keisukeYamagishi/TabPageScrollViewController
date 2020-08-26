//
//  RootViewController.swift
//  FunRecipes
//
//  Created by Shichimitoucarashi on 12/26/18.
//  Copyright © 2018 Shichimitoucarashi. All rights reserved.
//

import UIKit

public protocol TabPageDelegate {
    func willScrollPage(index: Int, viewController: UIViewController)
    func didScrollPage(index: Int, viewController: UIViewController)
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

        let filtering = Filtering(items: tabItems)

        headerView = UIView(frame: CGRect(x: 0,
                                          y: 0,
                                          width: view.frame.size.width,
                                          height: 32))

        pageView = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: view.frame.size.width,
                                        height: view.frame.size.height - headerView.frame.size.height))

        view.addSubview(pageView)
        view.addSubview(headerView)

        titles = filtering.titles
        vcs = filtering.viewControllers
        observer.delegate = self
        observer.viewControllers = filtering.viewControllers
        setChildViewController()
    }

    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        headerView.frame.origin.y = view.safeAreaInsets.top
        pageView.frame.origin.y = headerView.frame.origin.y + headerView.frame.size.height
    }

    private func setChildViewController() {
        addContainer(viewController: categoryViewController, containerView: headerView)
        addContainer(viewController: rootPageViewController, containerView: pageView)
    }

    private func addContainer(viewController: UIViewController, containerView: UIView) {
        addChild(viewController)
        viewController.view.frame = containerView.frame
        viewController.view.frame = CGRect(x: 0, y: 0, width: viewController.view.frame.size.width, height: viewController.view.frame.size.height)
        containerView.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }

    private var rootPageViewController: PageViewController {
        let rootPageViewController = PageViewController()
        rootPageViewController.observer = observer
        rootPageViewController.vcs = vcs
        return rootPageViewController
    }

    private var categoryViewController: CategoryCollectionViewController {
        let categoryViewController = CategoryCollectionViewController()
        categoryViewController.observer = observer
        categoryViewController.observer = observer
        categoryViewController.items = titles
        return categoryViewController
    }
}

@available(iOS 11.0, *)
extension TabPageScrollViewController: TabPageControllerDelegate {
    func willScrollPageViewController(index: Int, viewController: UIViewController) {
        delegate?.willScrollPage(index: index, viewController: viewController)
    }

    func didScrollPageViewController(index: Int, viewController: UIViewController) {
        delegate?.didScrollPage(index: index, viewController: viewController)
    }

    func tabChange(index: IndexPath, viewController: UIViewController) {
        delegate?.tabChangeNotify(index: index, vc: viewController)
    }

    func moveNavigationView(index: IndexPath) {
        delegate?.moveNavigationNotify(index: index)
    }
}
