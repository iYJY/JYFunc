//
//  TypeChangeIncident.swift
//  Tea
//
//  Created by chengda on 2016/10/27.
//  Copyright © 2016年 chengdachenshengbao. All rights reserved.
//

import UIKit

class TypeChangeIncident: NSObject {
    
    func passwordVisibleAction(_ imageView:UIImageView, textfield:UITextField, isVisible:Bool) -> Bool{
        if isVisible {
            imageView.image = UIImage(named: "password_visible")
            textfield.isSecureTextEntry = false
            return false
        }else{
            imageView.image = UIImage(named: "password_invisiable")
            textfield.isSecureTextEntry = true
            return true
        }
    }
}
