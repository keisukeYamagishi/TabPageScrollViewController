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
        
        let page:TabPageScrollViewController = pageView.topViewController as! TabPageScrollViewController
        page.delegate = self
        
        let vc1:ViewController = storyboard.instantiateViewController(withIdentifier: ViewController.identifer) as! ViewController
        vc1.number = 1
        let vc2:ViewController = storyboard.instantiateViewController(withIdentifier: ViewController.identifer) as! ViewController
        vc2.number = 2
        let vc3:ViewController = storyboard.instantiateViewController(withIdentifier: ViewController.identifer) as! ViewController
        vc3.number = 3
        let vc4:ViewController = storyboard.instantiateViewController(withIdentifier: ViewController.identifer) as! ViewController
        vc4.number = 4
        let vc5:ViewController = storyboard.instantiateViewController(withIdentifier: ViewController.identifer) as! ViewController
        vc5.number = 5
        let vc6:ViewController = storyboard.instantiateViewController(withIdentifier: ViewController.identifer) as! ViewController
        vc6.number = 6
        let vc7:ViewController = storyboard.instantiateViewController(withIdentifier: ViewController.identifer) as! ViewController
        vc7.number = 7
        let vc8:ViewController = storyboard.instantiateViewController(withIdentifier: ViewController.identifer) as! ViewController
        vc8.number = 8
        let vc9:ViewController = storyboard.instantiateViewController(withIdentifier: ViewController.identifer) as! ViewController
        vc9.number = 9
        let vc10:ViewController = storyboard.instantiateViewController(withIdentifier: ViewController.identifer) as! ViewController
        vc10.number = 10
        let vc11:ViewController = storyboard.instantiateViewController(withIdentifier: ViewController.identifer) as! ViewController
        vc11.number = 11
        
        page.tabItems = [TabItem(title: "Firsrt",vc: vc1),
                         TabItem(title: "Second",vc: vc2),
                         TabItem(title: "Third",vc: vc3),
                         TabItem(title: "Four",vc: vc4),
                         TabItem(title: "Five",vc: vc5),
                         TabItem(title: "Six",vc: vc6),
                         TabItem(title: "Seven",vc: vc7),
                         TabItem(title: "Eight",vc: vc8),
                         TabItem(title: "Nine",vc: vc9),
                         TabItem(title: "Ten",vc: vc10),
                         TabItem(title: "Eleven",vc: vc11)]
        pageView.setViewControllers([page], animated: false)
        self.window?.rootViewController = pageView
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

extension AppDelegate:TabPageDelegate{
    
    func tabChangeNotify(index: IndexPath, vc: UIViewController) {
        print ("index: \(index)")        
    }
    
    func moveNavigationNotify(index: IndexPath, vc: UIViewController) {
        print ("index: \(index)")
    }
}
