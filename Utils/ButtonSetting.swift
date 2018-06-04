//
//  ButtonSetting.swift
//  Tea
//
//  Created by chengda on 2016/11/14.
//  Copyright © 2016年 chengdachenshengbao. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire

class ButtonSetting: NSObject {

    //设置底部按钮
    func setCommonButton(_ button:UIButton) {
        
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.setBackgroundImage(UIImage(named: "button_normal"), for: UIControlState())
        button.setBackgroundImage(UIImage(named: "button_selected"), for: .highlighted)
        button.setBackgroundImage(UIImage(named: "button_invalid"), for: .disabled)
    }
    
    func setGetCodeButton(_ button :UIButton){
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.colorForHexadecimal(0xc0a49a, alpha: 1).cgColor
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        
        button.setTitleColor(mainRedColor, for: UIControlState())
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.setBackgroundImage(UIImage(named: "button_white_bg"), for: UIControlState())
        button.setBackgroundImage(UIImage(named: "button_selected"), for: .highlighted)
    }
}

class uploadImg {
    // 封装起来
    func uploadImg(_ image:UIImage,telephone:String,type :String,controller :UIViewController,complation:@escaping (String)->Void) {//两个地方上传头像type区分register，modify
        
        let urlAddress = UserDefaults.standard.string(forKey: UploadImageAddress)!
        
        let uploadFileUrl = urlAddress + "?platform=ios&command=headImg&telephone=" + telephone + "&type=" + type
        print("uploadFileUrl:\(uploadFileUrl)")
        let url = URL(string: uploadFileUrl)
        print("url:\(String(describing: url))")
        let imageData: Data?
        if (UIImagePNGRepresentation(image)==nil) {
            imageData = UIImageJPEGRepresentation(image,0.5)
        }else{
            imageData = UIImagePNGRepresentation(image)
        }
        if imageData != nil {
            let hud = MBProgressHUD.showAdded(to: (controller.navigationController?.view)!, animated: true)
            hud.label.text = "正在上传头像..."
            var request: URLRequest?
            do {
                request = try URLRequest(url: url!, method: .post)
            } catch let error {
                printLog("error:\(error)")
                MBHUDManager.sharedInstance.customShow(controller.view, addText: "上传头像失败")
                return
            }
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                multipartFormData.append(imageData!, withName: "file", fileName: "headImg.jpg", mimeType: "image/jpg")
            }, with: request!, encodingCompletion: { (encodingResult) in
            
                
//            })
            
//            Alamofire.upload(multipartFormData: { (multipartFormData) in
//                multipartFormData.appendBodyPart(data: imageData!, name: "file", fileName: "headImg.jpg", mimeType: "image/jpg")
//            }, to: url, encodingCompletion: { (encodingResult) in
//                <#code#>
//            })
//            
//            
//            
//            
//            
//            
//            Alamofire.upload(.POST, url!, multipartFormData: { (multipartFormData) in
//                multipartFormData.appendBodyPart(data: imageData!, name: "file", fileName: "headImg.jpg", mimeType: "image/jpg")
//            }) { (encodingResult) in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON(completionHandler: { (response) -> Void  in
                        hud.hide(animated: true)
                        let result = response.result.value
                        
                        if result == nil{
                            MBHUDManager.sharedInstance.customShow(controller.view, addText: "上传头像失败")
                            print("上传头像数据返回为空")
                            return
                        }
                        let resultDic = result as! NSDictionary
                        printLog("上传结果：\(resultDic.description)")
                        MBHUDManager.sharedInstance.customShow(controller.view, addText: resultDic["msg"] as! String)
                        let statusCode = resultDic["statusCode"] as! String
                        if statusCode == "10001"{
                            print("上传头像成功")
                            let userDefaults = UserDefaults.standard//NSUserDefaults.standardUserDefaults()
                            let data = resultDic["data"] as! NSDictionary
                            
                            let headImg = data["headImg"] as! String
                            userDefaults.setValue(headImg, forKey: HeadImgAddress)
                            userDefaults.synchronize()
                            complation(headImg)
                        }else{
                            print("上传头像失败")
                        }
                    })
                case .failure(let error):
                    hud.hide(animated: true)
                    MBHUDManager.sharedInstance.customShow(controller.view, addText: "上传头像失败")
                    print("uploadImg-failure:\(error)")
                }
            })
        }
    }
}
