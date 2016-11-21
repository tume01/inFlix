//
//  MainTabBarController.swift
//  inFlix
//
//  Created by Franco Tume on 11/21/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    var previousController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if previousController == viewController {
            if let navVC = viewController as? UINavigationController, let vc = navVC.viewControllers.first as? ScrollableToTopView {
                vc.scrollToTop()
            }
        }else{
            print("No same")
        }
        previousController = viewController
    }
}


protocol ScrollableToTopView {
    func scrollToTop()
}
