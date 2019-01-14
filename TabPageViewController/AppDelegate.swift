//
//  AppDelegate.swift
//  FunRecipes
//
//  Created by Shichimitoucarashi on 12/26/18.
//  Copyright © 2018 Shichimitoucarashi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        let st = UIStoryboard.init(name: "TabPage", bundle: nil)
        let pageView:UINavigationController = st.instantiateInitialViewController() as! UINavigationController
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        let page:TabPageViewController = pageView.topViewController as! TabPageViewController
        page.delegate = self
        page.tabItems = [TabItem(title: "Firsrt",vc: storyboard.instantiateViewController(withIdentifier: ViewController.identifer)),
                         TabItem(title: "Second",vc: storyboard.instantiateViewController(withIdentifier: ViewController.identifer)),
                         TabItem(title: "Third",vc: storyboard.instantiateViewController(withIdentifier: ViewController.identifer)),
                         TabItem(title: "Four",vc: storyboard.instantiateViewController(withIdentifier: ViewController.identifer)),
                         TabItem(title: "Five",vc: storyboard.instantiateViewController(withIdentifier: ViewController.identifer)),
                         TabItem(title: "Six",vc: storyboard.instantiateViewController(withIdentifier: ViewController.identifer)),
                         TabItem(title: "Seven",vc: storyboard.instantiateViewController(withIdentifier: ViewController.identifer)),
                         TabItem(title: "Eight",vc: storyboard.instantiateViewController(withIdentifier: ViewController.identifer)),
                         TabItem(title: "Nine",vc: storyboard.instantiateViewController(withIdentifier: ViewController.identifer)),
                         TabItem(title: "Ten",vc: storyboard.instantiateViewController(withIdentifier: ViewController.identifer)),
                         TabItem(title: "Eleven",vc: storyboard.instantiateViewController(withIdentifier: ViewController.identifer))]
        pageView.setViewControllers([page], animated: false)
        self.window?.rootViewController = pageView
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

extension AppDelegate:TabPageDelegate{
    func tabChangeNotify(index: IndexPath, vc: UIViewController) {
        let vc:ViewController = vc as! ViewController
        
        print ("Index: \(index.row)")
 
    }
    
    func moveNavigationNotify(index: IndexPath, vc: UIViewController) {
        let vc:ViewController = vc as! ViewController
        
        print("Index: \(index.row)")
        
    }
}
