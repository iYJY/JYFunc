//
//  CustomButton.swift
//  Tea
//
//  Created by houqinghui on 2016/12/16.
//  Copyright © 2016年 chengdachenshengbao. All rights reserved.
//

import UIKit

enum TypeBtn {
    case getCode
    case normal
}

class CustomButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var typeBtn :TypeBtn?
    
     required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func configureButton(){
//        self.addTarget(self, action: #selector(self.touchUpinside), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    var closure = {
        () -> () in
    }
    
    func touchUpinside() {
        self.backgroundColor = UIColor.black
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //self.actionTouch()
        
        if self.typeBtn == TypeBtn.getCode{
            self.setTitleColor(UIColor.white, for: UIControlState())
            //self.layer.borderWidth = 1
//            self.layer.borderColor = UIColor.colorForHexadecimal(0xea6a44, alpha: 1).cgColor
//            self.layer.cornerRadius = 3
            self.tintColor = UIColor.white
            self.backgroundColor = buttonBgColor
        }else if self.typeBtn == TypeBtn.normal{
            self.backgroundColor = UIColor.colorForHexadecimal(0x752a10, alpha: 1)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.closure()
        if self.typeBtn == TypeBtn.getCode{
            self.setTitleColor(buttonBgColor, for: UIControlState())
//            self.layer.borderWidth = 1
//            self.layer.borderColor = UIColor.colorForHexadecimal(0xea6a44, alpha: 1).cgColor
//            self.layer.cornerRadius = 3
            self.tintColor = buttonBgColor
            self.backgroundColor = UIColor.white
        }else if self.typeBtn == TypeBtn.normal{
            self.backgroundColor = buttonBgColor
            
        }
    }
}
