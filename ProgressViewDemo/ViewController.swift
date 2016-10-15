//
//  ViewController.swift
//  ProgressViewDemo
//
//  Created by Lishten on 15/12/4.
//  Copyright © 2015年 Lishten. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var progressView:CircleProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressView = CircleProgressView(frame: CGRectMake(50,50,250,250))
        self.view.addSubview(progressView)
//        progressView.status = NSLocalizedString("circle-progress-view.status-not-started", comment: "")
     
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
         self.progressView.progress = 0.5
         self.progressView.startAnimation()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

