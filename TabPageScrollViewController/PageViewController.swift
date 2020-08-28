//
//  RootPageViewController.swift
//  FunRecipes
//
//  Created by Shichimitoucarashi on 12/26/18.
//  Copyright © 2018 Shichimitoucarashi. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    var vcs: [UIViewController] = []
    weak var observer: TabPageObserver!

    var currentIndex: Int? {
        guard let viewController = viewControllers?.first else {
            return nil
        }
        return vcs.map { $0 }.firstIndex(of: viewController)
    }

    var beforeIndex: Int = 0

    override init(transitionStyle _: UIPageViewController.TransitionStyle,
                  navigationOrientation _: UIPageViewController.NavigationOrientation,
                  options _: [UIPageViewController.OptionsKey: Any]? = nil)
    {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self

        setScrollView()

        observer.tabBarNotify = self

        super.setViewControllers([vcs[0]],
                                 direction: .forward,
                                 animated: true,
                                 completion: nil)
    }

    private func setScrollView() {
        let scrollView = view.subviews.compactMap { $0 as? UIScrollView }.first
        scrollView?.scrollsToTop = false
        scrollView?.delegate = self
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(viewController: UIViewController, isAfter: Bool) -> UIViewController? {
        guard var index = vcs.map({ $0 }).firstIndex(of: viewController) else {
            return nil
        }

        if isAfter {
            index += 1
        } else {
            index -= 1
        }

        if index >= 0, index < vcs.count {
            return vcs[index]
        }
        return nil
    }

    func pageViewController(_: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        return pageViewController(viewController: viewController, isAfter: true)
    }

    func pageViewController(_: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        return pageViewController(viewController: viewController, isAfter: false)
    }
}

extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_: UIPageViewController,
                            willTransitionTo pendingViewControllers: [UIViewController])
    {
        observer.willScrollViewController(index: currentIndex!, viewController: pendingViewControllers.first!)
    }

    func pageViewController(_: UIPageViewController,
                            didFinishAnimating _: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted _: Bool)
    {
        observer.movePosition(index: currentIndex!)
        observer.didScrollViewController(index: currentIndex!, viewController: previousViewControllers.first!)
    }
}

extension PageViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        observer.pageScrollObserver(contetntOffset: scrollView.contentOffset)
    }
}

extension PageViewController: TabChangeNotify {
    func changeTagNotify(index: IndexPath) {
        if index.row != observer.selected {
            let direction: NavigationDirection!

            if index.row > observer.selected {
                direction = .forward
            } else {
                direction = .reverse
            }

            observer.tabCangeNotify(index: index.row, viewController: vcs[currentIndex!])

            super.setViewControllers([vcs[index.row]],
                                     direction: direction,
                                     animated: true,
                                     completion: nil)
        }
    }
}
