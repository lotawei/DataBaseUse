//
//  CLContentBtn.swift
//  DataBaseUse
//
//  Created by lotawei on 16/9/29.
//  Copyright © 2016年 lotawei. All rights reserved.
//

import UIKit

extension   String{
  static func sizewithtext(str:NSString,font:UIFont,maxsize:CGSize) -> CGSize {
        
        return   str.boundingRect(with: maxsize, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName:font], context: nil).size
        
        
    }
    
    
    
}

extension  UIImage{
    static  func  strechimg(img:String)->UIImage{
        var    newimg =  UIImage(named: img)
        
        newimg = newimg?.stretchableImage(withLeftCapWidth: Int((newimg?.size.width)!/2), topCapHeight:Int((newimg?.size.height)!/2))
        return  newimg!
    }
}

class CLContentBtn: UIButton {
    
    var  msg:CLMessage? = nil {
        didSet{
            caculatorframe()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
    }
    
    convenience   init(frame: CGRect,msg:CLMessage) {
        self.init(frame:frame)
      
        
        setTitleColor(UIColor.black, for: .normal)
        setTitle(msg.content, for: .normal)
        self.msg = msg
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        titleLabel?.numberOfLines  = 0
        
        backgroundColor = UIColor.white
        
        caculatorframe()
        
        
    }
    func   caculatorframe()
    {
        let   maxsize = CGSize(width: 100, height: 400)
        let   size =  String.sizewithtext(str: (msg?.content)! as NSString, font: UIFont.italicSystemFont(ofSize: 10), maxsize: maxsize)
        //外观可以根据这里调
        frame.size = CGSize(width: size.width + 200, height: size.height * 2 )
        
        
        var  img:UIImage?
        
        if  msg?.type != Usetype.Oneself {
            
            let    left = UIImage.strechimg(img: "left")
            
            img = left
            
            
        }
        else{
                     let    right = UIImage.strechimg(img: "right")
                    img = right
        }
        
        setBackgroundImage(img, for: .normal)
        
       
        
    }
    
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
