//
//  GetCodeCountdown.swift
//  Tea
//  获取验证码倒计时
//  Created by chengda on 2016/10/27.
//  Copyright © 2016年 chengdachenshengbao. All rights reserved.
//

import UIKit

class GetCodeCountdown: NSObject {
    
    var countdownNumber = 60
    var timer : Timer?
    var button : UIButton?
    
    
    func getCodeCountdown(_ button:UIButton) {
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(GetCodeCountdown.countdown), userInfo: nil, repeats: true)
        self.button = button
        self.button!.isEnabled = false
    }
    
    //倒计时
    func countdown() {
        if self.countdownNumber > 0 {
            self.button!.setTitle(self.countdownNumber.description + "s", for: UIControlState())
            //            button.titleLabel?.text = self.countdownNumber.description + "S后重新获取"
            self.button!.setTitleColor(textColor_B3, for: UIControlState())
//            self.button!.layer.borderColor = UIColor.clear.cgColor
            self.countdownNumber -= 1
        }else{
            //            button.titleLabel?.text = "重新获取"
            self.countdownNumber = 60
            self.button!.isEnabled = true
            self.button!.setTitle("重新获取", for: UIControlState())
            let titleColor = UIColor.colorForHexadecimal(0xea6a44, alpha: 1)
            self.button!.setTitleColor(titleColor, for: UIControlState())
//            self.button!.layer.borderColor = UIColor.colorForHexadecimal(0xea6a44, alpha: 1).cgColor
            self.timer?.invalidate()
            self.timer = nil
            
        }
    }
    
    func cancelTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
}
