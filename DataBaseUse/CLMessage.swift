//
//  CLMessage.swift
//  sqldataBaseUse
//
//  Created by lotawei on 16/9/23.
//  Copyright © 2016年 lotawei. All rights reserved.
//

import UIKit

extension   String{
    
    static  func   getcurrentime()->String{
        let date = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        let strNowTime = timeFormatter.string(from: date as Date)
        return  strNowTime 
    }
}
 enum Usetype:NSInteger {
    case Oneself,Other,Admin
}



class CLMessage: NSObject {
    var   type:Usetype!
    var   msgtime:String!
    var   username:String!
    var   icon:String!
    var   content:String? = nil{
        willSet{
            let   maxsize = CGSize(width: 100, height: 400)
            let   size =  String.sizewithtext(str: (newValue)! as NSString, font: UIFont.italicSystemFont(ofSize: 15), maxsize: maxsize)
            //外观可以根据这里调
            let   btnsize = CGSize(width: size.width * 2, height: size.height * 2  )
            self.cellheight = btnsize.height  +  110
            
            
            
            
        }
    }
    
    
    
    var   cellheight:CGFloat!
    
    
    
    
}
