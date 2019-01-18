# TabScrollPageViewController

[![](https://img.shields.io/badge/Twitter-O--Liker%20Error-blue.svg)](https://twitter.com/O_Linker_Error)
[![](https://img.shields.io/badge/lang-swift4.0-ff69b4.svg)](https://developer.apple.com/jp/swift/)
[![](https://img.shields.io/badge/licence-MIT-green.svg)](https://github.com/keisukeYamagishi/HttpRequest/blob/master/LICENSE)

## Overview

<img src="https://github.com/keisukeYamagishi/TabPageScrollViewController/blob/master/doc/pageScroll.gif">

The tab bar at the top of the screen moves synchronously with page scrolling.

When you press a tab, it will transition to the page you pressed.

It would be great if you would like to use UIPageViewController to build applications synchronized with the tab bar at the top of the screen.

## Cocoapods


[CocoaPods](https://cocoapods.org/pods/TabPageScrollViewController) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```
To integrate TabPageScrollViewController into your Xcode project using CocoaPods, specify it in your `Podfile`:

```
vi ./Podfile
```

```Podfile
target 'MyApp' do
  pod 'TabPageScrollViewController'
end
```

## Use it

***Via SSH***: For those who plan on regularly making direct commits, cloning over SSH may provide a better experience (which requires uploading SSH keys to GitHub):

```
$ git clone git remote add origin git@github.com:keisukeYamagishi/TabPageScrollViewController.git
```
***Via https***: For those checking out sources as read-only, HTTPS works best:

```
$ git clone https://github.com/keisukeYamagishi/TabPageScrollViewController.git
```

## Sample code

write in AppDelegate

```swift4
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
```

so nice 😏！
