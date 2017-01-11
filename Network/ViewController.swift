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


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let detailViewController = DetailViewController()
        detailViewController.segueIdentifier = "GET"
        detailViewController.request = Alamofire.request("https://httpbin.org/get")
        self.present(detailViewController, animated: true, completion: nil);
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

