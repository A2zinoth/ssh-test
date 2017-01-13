//
//  RootTabBarViewController.swift
//  Network
//
//  Created by mreport on 2017/1/12.
//  Copyright © 2017年 Beijing Minority Report Information Technology Co., Ltd. All rights reserved.
//

import UIKit


class RootTabBarViewController: UITabBarController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func tabBar(_ tabBar: UITabBar, didEndCustomizing items: [UITabBarItem], changed: Bool) {

    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.navigationItem.title =  self.viewControllers?[item.tag].title
        
        NSLog("\(self.selectedIndex)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NSLog("tab appear")
        self.tabBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tabBar.isHidden = true
        NSLog("tab disappear")
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
