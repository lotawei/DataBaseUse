//
//  ViewController.swift
//  sqldataBaseUse
//
//  Created by lotawei on 16/9/23.
//  Copyright © 2016年 lotawei. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITextFieldDelegate ,UITableViewDelegate,UITableViewDataSource{
    
    var   ismoveup:Bool =  false
    var   data:[CLMessage] = [CLMessage]()
    lazy var   textfield:UITextField = {
        let   textfiled = UITextField()
    textfiled.delegate = self
        return   textfiled
    }()
    lazy var   btnsend:UIButton = {
        let   btn = UIButton()
        btn.setTitle("发送", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        return   btn
    }()
      var  tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inittableview()
      
        initsenmsgView()

        
        
    }
    func inittableview()  {
        let   fr = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 150)
        let   tableView  = UITableView(frame: fr, style: .plain)
        tableView.delegate = self
        
        tableView.dataSource = self
       
        
        self.tableView = tableView
        self.tableView.separatorStyle = .none
        self.tableView.register(CLMessgeCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return  self.data.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let   reuseidentity  = "cell"
//        let     reuseidentity = String.init(format: "cell%d%d", indexPath.section,indexPath.row)
         var  messagecell = tableView.dequeueReusableCell(withIdentifier: reuseidentity) as?  CLMessgeCell
        let   message  =  self.data[indexPath.row]
        if messagecell == nil{
            messagecell =  CLMessgeCell(style: .default, reuseIdentifier: reuseidentity)
        }
     
        
        messagecell?.message = message
        
        return   messagecell!
    }
    
    
   
  
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return  self.data[indexPath.row].cellheight
    }
    
    func   initsenmsgView(){
       
        textfield.frame = CGRect(x: 10, y: ScreenHeight - 35, width: ScreenWidth / 4 * 3, height: 30)
        textfield.borderStyle = .roundedRect
        
        textfield.layer.borderWidth  =  1.0
        textfield.layer.borderColor = UIColor.blue.cgColor
        self.btnsend.addTarget(self, action: #selector(self.sendmsg), for: .touchUpInside)
        self.btnsend.frame = CGRect(x: textfield.frame.maxX + 10, y: ScreenHeight - 35, width: ScreenWidth / 4 - 5, height: 30)
         view.addSubview(self.textfield)
        view.addSubview(self.btnsend)
        
        
    }
    
    func randommsg(msgs:[CLMessage]) -> CLMessage {
        
        let    r = arc4random_uniform(UInt32(msgs.count))
        
        
        return   msgs[Int(r)]
    }
    
    func sendmsg()  {
        
        
        
        
        let  str  =  self.textfield.text
        
        let  msg = CLMessage()
        msg.username = "lw"
        msg.type = Usetype.Oneself
        msg.content = str
        msg.msgtime = String.getcurrentime()
        msg.icon = "po"
//        CLDBManager.sharedInstance.addimessage(msg: msg)
        
        self.data.append( msg)
        
        
        
       let  amsg =    CLDBManager.sharedInstance.responsemsg(str: str!)
        
        let  rms = self.randommsg(msgs: (amsg)!)
        self.data.append(rms)
        
        
        let   row = self.data.count - 1
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row:row,section:0), at: .bottom, animated: false)
    }
    
    private   func   moveup()
    {
        let animationDuration = 0.3
      
        UIView.beginAnimations("ResizeForKeyBoard", context: nil)
        
        UIView.setAnimationDuration(animationDuration)
        
        tableView.frame.origin.y -= 216
        textfield.frame.origin.y -= 280
        btnsend.frame.origin.y -= 280
        
        UIView.commitAnimations()
        
        ismoveup = true
    }
    private func  movedown()
    {
        let animationDuration = 0.3
        
        UIView.beginAnimations("ResizeForKeyBoard", context: nil)
        
        UIView.setAnimationDuration(animationDuration)
        
        tableView.frame.origin.y += 216
        textfield.frame.origin.y += 280
        btnsend.frame.origin.y += 280
        
        UIView.commitAnimations()
        ismoveup = false
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if   !ismoveup{
            moveup()
        }
        
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if ismoveup {
            movedown()
            self.view.endEditing(true)
        }
        return    true
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.navigationController?.pushViewController(TestViewController(), animated: true)
//    }
    
    
    
    
    
    
 
    

}

