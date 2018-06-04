//
//  Color.swift
//  Tea
//
//  Created by chengda on 16/7/5.
//  Copyright © 2016年 yisinian. All rights reserved.
//

import UIKit

// 常用颜色
let RedColor = UIColor(red: 248/255, green: 73/255, blue: 21/255, alpha: 1)
let GrayColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)
let ChingColor = UIColor(red: 54/255, green: 185/255, blue: 67/255, alpha: 1)
//let mainOrangeColor = UIColor(red: 254/255, green: 194/255, blue: 0, alpha: 1)

let teaColorUp = UIColor(red: 229/255, green: 82/255, blue: 31/255, alpha: 1)
//let teacolorDown = UIColor(red: 148/255, green: 193/255, blue:91/255 , alpha: 1)
let teacolorDown = UIColor(red: 131/255, green: 170/255, blue:23/255 , alpha: 1)
//let yellowColor = UIColor(red: 254/255, green: 194/255, blue:0/255 , alpha: 1)
let greenColor = UIColor(red: 92/255, green: 168/255, blue:56/255 , alpha: 1)
//let mainRedColor = UIColor.colorForHexadecimal(0x89381c, alpha: 1)
let mainRedColor = UIColor.colorForHexadecimal(0x3d3227, alpha: 1)
let redButtonColor = UIColor(red: 212/255, green: 60/255, blue:51/255 , alpha: 1)
let buttonBgColor = UIColor.colorForHexadecimal(0xea6a44, alpha: 1)
let mainColor = UIColor.colorForHexadecimal(0xea6a44, alpha: 1)

let grayTextColor75 = UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 1)
let labelRedLayerColor = UIColor.colorForHexadecimal(0xa06c37, alpha: 1)
let mainTextColor = UIColor.colorForHexadecimal(0x4d4d4d, alpha: 1)
let textColor_B3 = UIColor.colorForHexadecimal(0xb3b3b3, alpha: 1)
let backgroundColor_F5 = UIColor.colorForHexadecimal(0xf5f5f5, alpha: 1)
let textColor_99 = UIColor.colorForHexadecimal(0x999999, alpha: 1)
let textColor_EE3600 = UIColor.colorForHexadecimal(0xee3600, alpha: 1)
let buttonColor_Blue = UIColor.colorForHexadecimal(0x5AA3E8, alpha: 1)
let backgroundColor_F2 = UIColor.colorForHexadecimal(0xf2f2f2, alpha: 1)
let color_D6 = UIColor.colorForHexadecimal(0xd6d6d6, alpha: 1)
let textColor_2E = UIColor.colorForHexadecimal(0x2e2e2e, alpha: 1)
let textColor_48 = UIColor.colorForHexadecimal(0x484848, alpha: 1)
let PopupViewColor = UIColor.colorForHexadecimal(0x000000, alpha: 0.4)
let backgroundColor_EC = UIColor.colorForHexadecimal(0xececec, alpha: 1)
let backgroundColor_96 = UIColor.colorForHexadecimal(0x969696, alpha: 1)
let CircleOfTeaFriendsBlueColor = UIColor.colorForHexadecimal(0x386191, alpha: 1)
let backgroundColor_ED = UIColor.colorForHexadecimal(0xededed, alpha: 1)
let color_EE3600 = UIColor.colorForHexadecimal(0xee3600, alpha: 1)
// 十六进制获取颜色uicolor 例如 UIColor.colorForHexadecimal(0xc0a49a, alpha: 1)
extension UIColor{

    static func colorForHexadecimal(_ hexString :NSInteger,alpha :CGFloat) -> UIColor{
        let red   = CGFloat((hexString & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hexString & 0x00FF00) >> 8) / 255.0
        let blue  = CGFloat((hexString & 0x0000FF)) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}


extension UIButton{

    class func setUpBtn(_ borderWidth : CGFloat,borderColor : UIColor,corderRadio: CGFloat) {
        
    }
}


