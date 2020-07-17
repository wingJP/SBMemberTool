//
//  ViewController.swift
//  LTWorkTool
//
//  Created by 小毅 on 07/03/2020.
//  Copyright (c) 2020 小毅. All rights reserved.
//

import UIKit
import LTWorkTool

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Test.shared.testPrint()
        
        
        
    }
    @IBAction func next(_ sender: Any) {
        let vc = DevSettingViewController()
               self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func share(_ sender: Any) {
        MemberToolBox.shareApp(onViewController: self)
    }
    @IBAction func commimt(_ sender: Any) {
        MemberToolBox.commentsAtAppStore()
    }
    @IBAction func store(_ sender: Any) {
    }
 
    @IBAction func openhtml(_ sender: Any) {
        MemberToolBox.presentWebPage(onViewController: self,
        url: "http://www.shenbihuyu.com/app_privacy.html",
        title: "隐私政策")
    }
    @IBAction func appid(_ sender: Any) {
      let appid =   MemberToolBox.appId()
        print("=======  \(appid)")
    }
    @IBAction func appVersion(_ sender: Any) {
        let v = MemberToolBox.appVersion()
        print("=======  \(v)")
    }
    @IBAction func appName(_ sender: Any) {
        let name = MemberToolBox.appName()
        print("=======  \(name)")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

