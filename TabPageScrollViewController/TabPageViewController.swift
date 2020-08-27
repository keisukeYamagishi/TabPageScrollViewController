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
//    var headerView: UIView!
    var pageView: UIView!
    private var barItem: UIBarButtonItem!
    public var categoryView: CategoryView!
    private var isUp = false
    private var titles: [String] = []
    private var vcs: [UIViewController] = []

    override open func viewDidLoad() {
        super.viewDidLoad()

        let filtering = Filtering(items: tabItems)
        vcs = filtering.viewControllers

        categoryView = CategoryView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: view.frame.size.width,
                                                  height: 32),
                                    items: filtering.titles)

        pageView = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: view.frame.size.width,
                                        height: view.frame.size.height - categoryView.frame.size.height))

        view.addSubview(pageView)
        view.addSubview(categoryView)

        observer.delegate = self
        categoryView.observer = observer
        observer.viewControllers = filtering.viewControllers
        setChildViewController()
    }

    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        categoryView.frame.origin.y = view.safeAreaInsets.top
        pageView.frame.origin.y = categoryView.frame.origin.y + categoryView.frame.size.height
    }

    private func setChildViewController() {
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
