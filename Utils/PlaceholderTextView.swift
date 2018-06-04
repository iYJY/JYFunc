//
//  PlaceholderTextView.swift
//  icampus
//
//  Created by chengda on 2017/6/16.
//  Copyright © 2017年 aixiao. All rights reserved.
//

import UIKit

class PlaceholderTextView: UITextView {

    var placeholder = ""      //占位文字
    var placeholderColor: UIColor?  //占位文字颜色
    var textFont: UIFont = UIFont.systemFont(ofSize: 14)         //字体大小
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        //如果有文字，就直接返回，不需要占位文字
        if self.hasText {
            return
        }
        
        //属性
        var attrs = [String: AnyObject]()
        attrs[NSFontAttributeName] = self.textFont
        attrs[NSForegroundColorAttributeName] = self.placeholderColor
        
        //画文字
        var newRect = rect
        newRect.origin.x = 5
        newRect.origin.y = 8
        newRect.size.width -= 2 * newRect.origin.x
        let placeholderNSString = NSString(string: self.placeholder)
//        placeholderNSString.draw(in: newRect, withAttributes: attrs)
        placeholderNSString.draw(in: newRect, withAttributes: attrs)
    }
 
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.font = self.textFont
        self.placeholderColor = UIColor.gray
//        NotificationCenter.default.addObserver(self, selector: #selector(self.textDidChange(aNotification:)), name: .UITextViewTextDidChange, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(self.textDidChange(_:)), name: NSNotification.Name.UITextViewTextDidChange, object: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func textDidChange(_ aNotification: Notification) {
        self.setNeedsDisplay()
    }
    
    deinit {
//        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(self)
    }
    
}
