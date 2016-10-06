//
//  CLDBManager.swift
//  sqldataBaseUse
//
//  Created by lotawei on 16/9/23.
//  Copyright © 2016年 lotawei. All rights reserved.
//

import UIKit
 private let shareinstance = CLDBManager()
class CLDBManager: NSObject {
     private   var    defaultdata:[CLMessage] = [CLMessage]()
    class var sharedInstance : CLDBManager {
        
        shareinstance.preparedata()
        
        return shareinstance
    }
    
    
    private   func  filename()->String{

        let   doc = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        var  path =  doc as  NSString
        
        path = path.appendingPathComponent("imesage.sqlite") as NSString
        return   path as String
     
    }
    
    
 
    //批量插入一些数据用起来
    
   private   func  preparedata(){
        print(self.filename())
        self.initdefaultdata()
        let   quene = FMDatabaseQueue(path: self.filename())
       
        quene?.inDatabase({ (db) in
            if( db?.executeUpdate("create  table if not  exists imessage ( username  text  ,icon text ,content text,msgtime  text,type  integer)", withArgumentsIn: nil))!
            {
                print("创建成功！")
            }
            else{
                print("创建失败")
            }
            
            for   i  in 0..<self.defaultdata.count
            {
                
                
                let  msg  =  self.defaultdata[i] 
                db?.executeUpdate("insert  into imessage(username,icon,content,msgtime,type) values(?,?,?,?,?)", withArgumentsIn: [msg.username,msg.icon,msg.content,String.getcurrentime(),msg.type.hashValue])
            }
            
            
            
        })
        
        
        
        
    }


    private   func   initdefaultdata(){
         //准备的话都准备些系统的 消息
        let    chareters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
        for i in 0..<26 {
            let   msg  = CLMessage()
            msg.content = "来自(beauty):\(chareters[i])"
            msg.username = "beauty"
            msg.type =  .Admin
            msg.icon = "default"
            msg.msgtime = String.getcurrentime()
            defaultdata.append(msg)
            
           
            
            
        }
        
        
    }
  
    
    
    
    func  addimessage(msg:CLMessage){
        let   quene = FMDatabaseQueue(path: self.filename())
        print(self.filename())
        quene?.inDatabase({ (db) in
          
            let  user = UserDefaults.standard
            
            let   pre =  user.string(forKey: "prepared")
            if  (pre != nil) {
                return
            }
            if (db?.executeUpdate("insert  into imessage(username,icon,content,msgtime,type) values(?,?,?,?,?)", withArgumentsIn: [msg.username,msg.icon,msg.content,String.getcurrentime(),msg.type.hashValue]))!
                
            {
                print("插入成功！")
                let  user = UserDefaults.standard
                
                user.set("prepared", forKey: "prepared")
                
                
            }
        })
        
        
        
        
    }
    
    
    func  responsemsg(str:String) ->  [CLMessage]? {
        var    msgs:[CLMessage]?
        let   quene = FMDatabaseQueue(path: self.filename())
        quene?.inDatabase({ (db) in
            
         let  result =    db?.executeQuery("select  *from  imessage  where username = ? ", withArgumentsIn: ["beauty"])
            msgs = [CLMessage]()
            while(result?.next())!{
          
              let    msg = CLMessage()
                msg.content = result?.object(forColumnName: "content") as?  String
                 msg.username = result?.object(forColumnName: "username") as?  String
                msg.icon = result?.object(forColumnName: "icon") as?  String
                 msg.type = (result?.object(forColumnName: "type") as?  Int).map { Usetype(rawValue: $0) }!
                msg.msgtime  = result?.object(forColumnName: "msgtime") as?  String
                
                msgs?.append(msg)
                
            }
            
            
            
        })
        return  msgs!
        
        
    }
    
  
    
    
            
    
    
    
}
