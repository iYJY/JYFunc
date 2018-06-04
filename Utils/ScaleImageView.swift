//
//  ScaleImageView.swift
//  Tea
//
//  Created by chengda on 2017/8/11.
//  Copyright © 2017年 chengdachenshengbao. All rights reserved.
//

import UIKit

protocol ScaleImageViewDelegate {
    func imageViewSingleClick(_ imageView: ScaleImageView)
}

let MaxScale: CGFloat = 5    //最大缩放比例
let MinScale: CGFloat = 1    //最小缩放比例

class ScaleImageView: UIImageView, UIGestureRecognizerDelegate {

    var lastScale: CGFloat = 1//记录最后一次的图片放大倍数
    
//    /**手机屏幕高度不够用的时候 用于显示完整图片*/
//    var scrollView: UIScrollView?
//    /**完整图片*/
//    var scrollImgV: UIImageView?
    /**用于放大 缩小 图片的scrollview*/
    var scaleScrollView: UIScrollView?
    /**用于显示 放大缩小的 图片*/
    var scaleImgV: UIImageView?
    var doubleAction: Bool?
    
    var scaleImgDelegate: ScaleImageViewDelegate?
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        let ges = UIPinchGestureRecognizer(target: self, action: #selector(self.scaleImageViewAction(_:)))
        ges.delegate = self
        self.lastScale = 1
        self.addGestureRecognizer(ges)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.singleClick(_:)))
        self.addGestureRecognizer(singleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.doubleClick(_:)))
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
        singleTap.require(toFail: doubleTap)
    }
    
    func setSubView() {
        
        if self.scaleScrollView == nil {
            self.scaleScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))//[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
            self.scaleScrollView?.bounces = false
            self.scaleScrollView?.backgroundColor = UIColor.black//[UIColor blackColor];
            self.scaleScrollView?.contentSize = self.bounds.size
            self.addSubview(self.scaleScrollView!)//[self addSubview:_scaleScrollView];
        }
        
        if self.scaleImgV == nil && self.image != nil {
//            self.scaleImgV = UIImageView()
            if (self.image?.size.height)! / (self.image?.size.width)! > self.frame.size.height / self.frame.size.width {
                let width = self.image!.size.width / self.image!.size.height * self.frame.size.height
                self.scaleImgV = UIImageView(frame: CGRect(x: (self.frame.size.width - width)/2, y: 0, width: width, height: self.frame.size.height))
            }else if (self.image?.size.height)! / (self.image?.size.width)! < self.frame.size.height / self.frame.size.width{
                let height = self.image!.size.height / self.image!.size.width * self.frame.size.width
                self.scaleImgV = UIImageView(frame: CGRect(x: 0, y: (self.frame.size.height - height)/2, width: self.frame.size.width, height: height))
            }else{
                self.scaleImgV = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
            }
            self.scaleImgV?.image = self.image
            self.scaleScrollView?.addSubview(scaleImgV!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        let imageSize = self.image?.size
//        printLog("imageSize:\(imageSize)")
//        //图片高度大于屏幕高度
//        if self.frame.size.width * ((imageSize?.height)! / (imageSize?.width)!) > self.frame.size.height {
//            self.scrollView?.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.width * ((imageSize?.height)! / (imageSize?.width)!))
//            self.scrollImgV?.center = (self.scrollView?.center)!
//            self.scrollImgV?.bounds = CGRectMake(0, 0, (imageSize?.width)!, self.frame.size.width * ((imageSize?.height)! / (imageSize?.width)!))
//        }else{
//            self.scrollView?.removeFromSuperview()
//        }
//        
//    }
    
    func scaleImageViewAction(_ gesture: UIPinchGestureRecognizer) {

        let scale = gesture.scale
        printLog("scale:\(scale)")
        self.setSubView()
        let shouldScale = self.lastScale + (scale - 1)//我们需要知道的是当前手势相收缩率对于刚才手势的相对收缩 scale - 1，然后加上最后一次收缩率，为当前要展示的收缩率
        if shouldScale > 0.2 {
            self.setScaleImage(shouldScale)
            gesture.scale = 1   //图片大小改变后设置手势scale为1
        }
        
        if gesture.state == .ended {    //当手势完成时，重新设置为最大或最小缩放比例
            if (self.lastScale > MaxScale) {
                self.lastScale = MaxScale
                self.setScaleImage(self.lastScale)
            }else if(self.lastScale < MinScale){
                self.lastScale = MinScale
                self.setScaleImage(self.lastScale)
            }
        }
    }
    
    //单击
    func singleClick(_ gesture: UITapGestureRecognizer) {
        self.scaleImgDelegate?.imageViewSingleClick(self)
    }
    
    //双击
    func doubleClick(_ gesture: UITapGestureRecognizer) {
        if self.lastScale > 1 {
            self.lastScale = 1
        }else{
            self.lastScale = 2
        }
        self.setSubView()
        UIView.animate(withDuration: 0.5, animations: { 
            self.setScaleImage(self.lastScale)
            }, completion: { (finish) in
                printLog("self.lastScale:\(self.lastScale)")
                if self.lastScale == 1 {
                    self.resetView()
                }
        }) 
    }
    
    //当达到原图大小 清除 放大的图片 和scrollview
    func resetView() {
        if self.scaleScrollView == nil {
            return
        }
        self.scaleScrollView?.isHidden = true
        self.scaleScrollView?.removeFromSuperview()
        self.scaleScrollView = nil
        self.scaleImgV = nil
    }

    //图片缩放
    func setScaleImage(_ scale: CGFloat, maxScale: CGFloat = MaxScale, minScale: CGFloat = MinScale) {
        //最大2倍最小.5
        self.lastScale = scale
        printLog("self.lastScale:\(self.lastScale)")
        printLog("self.scaleImgV?.frame.width:\(String(describing: self.scaleImgV?.frame.width))")
        printLog("self.scaleImgV?.frame.height:\(String(describing: self.scaleImgV?.frame.height))")
//        self.scaleImgV?.transform = CGAffineTransformMakeScale(scaleMultiple, scaleMultiple)
        self.scaleImgV?.transform = CGAffineTransform(scaleX: scale, y: scale)
        printLog("self.scaleImgV?.frame.width-transform:\(String(describing: self.scaleImgV?.frame.width))")
        printLog("self.scaleImgV?.frame.height-transform:\(String(describing: self.scaleImgV?.frame.height))")
//        if (scaleMultiple > 1) {
        if (scale > 1) {
            let imageWidth = /*self.scaleImgV?.frame.width*/max((self.scaleImgV?.frame.width)!, self.frame.size.width)//max((self.scaleImgV?.frame.width)!, self.frame.width) //self.scaleImgV?.bounds.width
            printLog("imageWidth:\(imageWidth)")
            let imageHeight = /*self.scaleImgV?.frame.height*/max((self.scaleImgV?.frame.height)!, self.frame.size.height)// MAX(image.height, self.frame.size.height)
            //            [self bringSubviewToFront:self.scaleScrollView];
            printLog("imageHeight:\(imageHeight)")
            printLog("self.scaleImgV?.frame.width>1:\(String(describing: self.scaleImgV?.frame.width))")
            printLog("self.scaleImgV?.frame.height>1:\(String(describing: self.scaleImgV?.frame.height))")
            self.bringSubview(toFront: self.scaleScrollView!)
            self.scaleImgV?.center = CGPoint(x: imageWidth * 0.5, y: imageHeight * 0.5)
            self.scaleScrollView?.contentSize = CGSize(width: imageWidth, height: imageHeight)
            var offset = self.scaleScrollView?.contentOffset
            offset!.x = (imageWidth - self.frame.size.width)/2.0
            offset!.y = (imageHeight - self.frame.size.height)/2.0
            printLog("offset:\(String(describing: offset))")
            self.scaleScrollView?.contentOffset = offset!
//            self.scaleImgV?.center = (scaleScrollView?.center)!
        }else{
            self.scaleImgV?.center = (self.scaleScrollView?.center)!
            self.scaleScrollView?.contentSize = CGSize.zero
        }
    }
}
