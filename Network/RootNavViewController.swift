//
//  RootNavViewController.swift
//  Network
//
//  Created by mreport on 2017/1/12.
//  Copyright © 2017年 Beijing Minority Report Information Technology Co., Ltd. All rights reserved.
//

import UIKit

typealias NoticeBlock = (Int) -> (Int)


class RootNavViewController: UINavigationController, UINavigationControllerDelegate {

    var backBlock: NoticeBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("nav appear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NSLog("nav disappear")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        NSLog("nav did show")
        NSLog("\(viewController)")
        if viewController.isKind(of: ViewController.classForCoder()) {
            NSLog("回到tab")
            backBlock!(1)
        }
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
