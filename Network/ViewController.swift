//
//  ViewController.swift
//  Network
//
//  Created by mreport on 2017/1/10.
//  Copyright © 2017年 Beijing Minority Report Information Technology Co., Ltd. All rights reserved.
//


import UIKit
import Alamofire


class ViewController: UIViewController {

    var blurBackView: UIView?

    func blurBackViews() -> UIView {
        blurBackView = UIView()
        blurBackView?.frame = CGRect(x: 0, y: -20, width: UIScreen.main.bounds.width, height: 64)
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64)
        
        gradientLayer.colors = [UIColor(colorLiteralRed: 4, green: 0, blue: 18, alpha: 0.76).cgColor,UIColor(colorLiteralRed: 4, green: 0, blue: 18, alpha: 0.28).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1.0)
        blurBackView?.layer.addSublayer(gradientLayer)
        blurBackView?.alpha = 0.5
        
        return blurBackView!
    }
    
    
//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        
//        return UIStatusBarStyle.LightContent;
//        
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.hidesBottomBarWhenPushed = true
        self.title = "WeChat" // Tabbar title
//        self.navigationItem.title =  "WeChat"
        
//        self.view.backgroundColor = UIColor.green
    
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
//        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
 
        
//        self.navigationController?.navigationBar.didAddSubview(blurBackViews())
//        self.navigationController?.navigationBar = CustomNavBar()
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let detailViewController = DetailViewController()
        detailViewController.segueIdentifier = "GET"
        detailViewController.request = Alamofire.request("https://httpbin.org/get")
//        self.present(detailViewController, animated: true, completion: nil);
//        let tbVC: UITabBarController = UIApplication.shared.keyWindow?.rootViewController as! UITabBarController
//        let nav:UINavigationController = tbVC.selectedViewController as! UINavigationController
//        nav.pushViewController(detailViewController, animated: true)
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController {
    
}

