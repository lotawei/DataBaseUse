//
//  TestViewController.swift
//  DataBaseUse
//
//  Created by lotawei on 16/9/29.
//  Copyright © 2016年 lotawei. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    let    msg = CLMessage()
    
    
    var    btn:CLContentBtn?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        msg.content  = "奥斯卡奖金按时交付件案件是进口的金卡手机看的爱上的金卡手机看大家考试的骄傲手机看大家爱开始登记卡就开始的金卡手机看大家考试的金卡手机卡登记卡刷卡机大家开始"
        msg.type = Usetype.Admin
        
        let   aframe = CGRect(x: 0, y: 200, width: 0, height: 0)
        btn = CLContentBtn(frame: aframe, msg: msg)
        
        
        self.view.addSubview(btn!)
        
        
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
