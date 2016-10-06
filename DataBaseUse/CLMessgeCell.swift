//
//  CLMessgeCell.swift
//  sqldataBaseUse
//
//  Created by lotawei on 16/9/23.
//  Copyright © 2016年 lotawei. All rights reserved.
//

import UIKit

class CLMessgeCell: UITableViewCell {
    
   lazy var    msglable:UILabel  = {
        let    msglable =  UILabel()
        msglable.font  =  UIFont.systemFont(ofSize: 10)
        msglable.tintColor = UIColor.gray
    return   msglable
}()
    
    var    conentbtn:UIButton = UIButton()
    
    
    var    message:CLMessage? = nil {
        willSet{
            imageView?.image = UIImage(named: (newValue?.icon)! )
            msglable.text = newValue?.msgtime
            var  img:UIImage?
            let   maxsize = CGSize(width: 150, height:9999)
            let   size =  String.sizewithtext(str: (newValue?.content)! as NSString, font: UIFont.italicSystemFont(ofSize: 15), maxsize: maxsize)
            //外观可以根据这里调
            let   btnsize = CGSize(width: size.width * 2, height: size.height * 2  )
           conentbtn.frame.size =  btnsize
            if  newValue?.type != Usetype.Oneself {
                
                let    left = UIImage.strechimg(img: "left")
                
                img = left
                
                
            }
            else{
                let    right = UIImage.strechimg(img: "right")
                img = right
            }
            
            conentbtn.setBackgroundImage(img, for: .normal)
            
            conentbtn.setTitle(newValue?.content, for: .normal)
            
            frame.size = CGSize(width: ScreenWidth, height: btnsize.height + 60)
            
            
            setNeedsLayout()
            }
    }
   override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         self.contentView.addSubview(self.msglable)
        conentbtn.contentMode = .topLeft
        conentbtn.titleLabel?.numberOfLines = 0
        self.contentView.addSubview(self.conentbtn)
    
        contentView.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    override  func layoutSubviews() {
        super.layoutSubviews()
        
      
        
        //对其进行重新布局
        let   mgsx = ScreenWidth / 2  - 25
        self.msglable.frame = CGRect(x: mgsx, y: 5, width: 50, height: 20)
        
        if message?.type  == Usetype.Oneself {
            //头像放→_→
            imageView?.frame = CGRect(x: ScreenWidth - 50 - 3, y: 23 , width: 50, height: 50)
            
             conentbtn.frame.origin = CGPoint(x: ScreenWidth -  50 - (conentbtn.frame.size.width) - 3  , y: (imageView?.frame.maxY)! - 3)
            
           
            
        }
        else{
            //头像放左边
              imageView?.frame = CGRect(x: 3, y: 23, width: 50, height: 50)
            
              conentbtn.frame.origin = CGPoint(x: (imageView?.frame.maxX)! + 3  , y: (imageView?.frame.maxY)! - 3)

        }
        imageView?.layer.cornerRadius  =   25
        imageView?.clipsToBounds = true
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
