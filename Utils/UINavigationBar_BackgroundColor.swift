//
//  UINavigationBar_BackgroundColor.swift
//  Tea
//
//  Created by houqinghui on 2016/11/17.
//  Copyright © 2016年 chengdachenshengbao. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar{

    var overlay :UIView?{
        get{
        
            return UIView(frame: CGRectMake(0, -20, SCREEN_WIDTH, self.bounds.size.height + 20))
        }
        
        set{}
    }
    
    func en_setBackgroundColor(color :UIColor){
    
        //if self.overlay == nil{
        self.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.overlay?.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        self.insertSubview(self.overlay!, atIndex: 0)
       // }
        self.overlay?.backgroundColor = color
    }

}
