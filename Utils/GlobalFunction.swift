//
//  PrintLog.swift
//  store
//
//  Created by chengda on 16/8/22.
//  Copyright © 2016年 chengda. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import RealmSwift

    //打印
    func printLog<T>(_ message: T, file:String = #file, method:String = #function, line: Int = #line) {
        #if DEBUG
            print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
        #endif
    }

    func setButtonCornerRadius(_ button:UIButton) {
        button.layer.cornerRadius = 3
    }

    protocol InitNetworkingDelegate{
    //代理方法
        func initNetworkingResult(_ result:Int)
    }

    class GlobalFunction{
    
    static var delegate : InitNetworkingDelegate?
    
//    class func initNetwording(todo:Int){
//        printLog("初始化中")
//        let para = ["chen":"chen"]
//        PostRequestsFactory.createJsonRequest("", params: para, hostType: addressType.initAddress , encrypt: false).sendRequestWithCompletion({ (response :Response<HttpDataMapModel<InitModel>,NSError>) -> Void in
//            
//            let result = response.result.value
//            
//            if result == nil {
//                printLog("initnewwording is off ")
//                self.delegate?.initNetworkingResult(0)
//                return
//            }
//            printLog("initNetwording*******\(result?.getJsonString())")
//            printLog(response.timeline)
//            
//            switch result!.statusCode{
//            case HttpStatusCode.Code_Success.rawValue:
//                printLog(result?.data?.address)
//                let userDefault = NSUserDefaults.standardUserDefaults()
//                userDefault.setValue(result?.data?.address, forKey: READ_ADDRESS)
//                userDefault.setValue(result?.data?.uploadImageAddress, forKey: UPLOAD_IMAGE_ADDRESS)
//                userDefault.setValue(result?.data?.qrAddress, forKey: QR_ADDRESS)
//                userDefault.setValue(result?.data?.headAddress, forKey: HEAD_ADDRESS)
//                userDefault.setValue(result?.data?.shopAgreement, forKey: SERVICE_PROTOCOL_ADDRESS)
//                userDefault.setValue(result?.data?.shopPic, forKey: SHOP_PICTURE_ADDRESS)
//                userDefault.synchronize()
//
//                self.delegate?.initNetworkingResult(todo)
//            default:
//                self.delegate?.initNetworkingResult(0)
//            }
//        })
//    }
    
    class func showTextField(_ textField:UITextField, view:UIView) {
        let textFieldHeight = textField.frame.origin
        let viewHeight = view.frame.height
        printLog("textFieldHeight:\(textFieldHeight.y)")
        printLog("viewHeight:\(viewHeight)")
        if textFieldHeight.y > viewHeight-271{
            let newRect = CGRect(x: 0, y: viewHeight-271-textFieldHeight.y-textField.frame.height, width: view.frame.width, height: view.frame.height)
            view.frame = newRect
        }
    }
    
    func resignTextfieldFirstResponder(_ textfield:UITextField) {
        if textfield.isFirstResponder {
            textfield.resignFirstResponder()
        }
    }
}

// 判断机型
func isIPhone5() -> Bool {
    return UIScreen.main.currentMode?.size == CGSize(width: 640, height: 1136)
}

func isIPhone6() -> Bool {
    return UIScreen.main.currentMode?.size == CGSize(width: 750, height: 1334)
}

func isIPhone6Plus() -> Bool {
    return UIScreen.main.currentMode?.size == CGSize(width: 1242, height: 2208)
}

func isIPhoneX() -> Bool {
    return UIScreen.main.currentMode?.size == CGSize(width: 1125, height: 2436)
}

// 多个textfield  键盘隐藏
func keyBoard(_ textField :UITextField?...){
    for item in textField{
        if item == nil {
            continue
        }
        if (item?.isFirstResponder)!{
            item?.resignFirstResponder()
        }
    }
}

// 得到字符串的高度
func getTextHeight(_ text :String,width: CGFloat,fontSize :CGFloat = 14) -> CGFloat {
    
    let textNormal = text as NSString
    let size = CGSize(width: width, height: 1000)
    let font = UIFont.systemFont(ofSize: fontSize)
    let dic = NSDictionary(object: font , forKey: NSFontAttributeName as NSCopying)
    let strSize = textNormal.boundingRect(with: size, options: .usesLineFragmentOrigin , attributes: dic as? [String : AnyObject], context: nil).size
    return strSize.height
}

//价格数字格式
func attributeText(_ text : String?,suffix: String = "", prefix:Bool = true) -> String {
    
//    var str = (text as NSString).componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString:".")).first!
    
//    var attText = ""
    var intText = ""
    
    let format = NumberFormatter.init()
    printLog("text:\(text ?? "")")
    if text == nil || text == "" {
        return ""
    }
    if prefix {
        format.numberStyle = .decimal
        // 小数位最多位数
        format.maximumFractionDigits = 2;
        if suffix == ""{
//            intText = "￥" + format.stringFromNumber(NSNumber(float: Float.init(text)!))!
            intText = "￥" + format.string(from: NSNumber(value: Double(text!)! as Double))!
//            intText = attText.substringToIndex(attText.endIndex.advancedBy(-3))
            printLog("intText:\(intText)")
        }else{
            
            intText = "￥" + format.string(from: NSNumber(value: Double(text!)! as Double))! + "/" + suffix
//            intText = attText.substringToIndex(attText.endIndex.advancedBy(-3)) + "/" + suffix
        }
    }else{
        format.numberStyle = .decimal
        // 小数位最多位数
        format.maximumFractionDigits = 2;
        if suffix == ""{
//            if text == "0"{
//                attText = ""
//            }else{
                intText = format.string(from: NSNumber(value: Double(text!)! as Double))!
//            }
        }else{
//            if text  == "0"{
//                attText = ""
//            }else{
                intText = format.string(from: NSNumber(value: Double(text!)! as Double))! + suffix
//            }
        }
    }
    
    return intText
}

//价格数字格式,两位小数
func attributeTextTwoFractionDigits(_ text : String?,suffix: String = "", prefix:Bool = true) -> String {
    
    //    var str = (text as NSString).componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString:".")).first!
    
    //    var attText = ""
    var intText = ""
    
    let format = NumberFormatter.init()
    printLog("text:\(text ?? "")")
    if text == nil || text == "" {
        return ""
    }
    if prefix {
        format.numberStyle = .decimal
        // 小数位最2位数
        format.maximumFractionDigits = 2
        format.minimumFractionDigits = 2
        if suffix == ""{
            //            intText = "￥" + format.stringFromNumber(NSNumber(float: Float.init(text)!))!
            intText = "￥" + format.string(from: NSNumber(value: Double(text!)! as Double))!
            //            intText = attText.substringToIndex(attText.endIndex.advancedBy(-3))
            printLog("intText:\(intText)")
        }else{
            
            intText = "￥" + format.string(from: NSNumber(value: Double(text!)! as Double))! + "/" + suffix
            //            intText = attText.substringToIndex(attText.endIndex.advancedBy(-3)) + "/" + suffix
        }
    }else{
        format.numberStyle = .decimal
        // 小数位2位数
        format.maximumFractionDigits = 2
        format.minimumFractionDigits = 2
        if suffix == ""{
            //            if text == "0"{
            //                attText = ""
            //            }else{
            intText = format.string(from: NSNumber(value: Double(text!)! as Double))!
            //            }
        }else{
            //            if text  == "0"{
            //                attText = ""
            //            }else{
            intText = format.string(from: NSNumber(value: Double(text!)! as Double))! + suffix
            //            }
        }
    }
    
    return intText
}

//时间显示
func formateDateShow(_ date:String) -> String{
    printLog("needDate:\(date)")
    if date == "" || date == "0"{
        return ""
    }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let nowDate = Date()
    printLog("nowDate:\(nowDate)")
    let needFormatDate = dateFormatter.date(from: date)
    let time = nowDate.timeIntervalSince(needFormatDate!)
    if time < 60*60{
        let mins = Int.init(time/60).description + "分钟前"
        return mins
    }else if time < 60*60*24{
        let hours = Int.init(time/60/60).description + "小时前"
        return hours
    }else{
        dateFormatter.dateFormat = "MM-dd"
        return dateFormatter.string(from: needFormatDate!)
    }
}

//月日时间显示
func formateDateShowMonthAndDay(_ date:String) -> String{
    printLog("needDate:\(date)")
    if date == "" || date == "0"{
        return ""
    }
    if date != "" && date != "0"{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let needFormatDate = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "M月d号"
        return dateFormatter.string(from: needFormatDate!)
    }else{
        return ""
    }
}

//显示月份
func formateDateShowMonth(_ date:String) -> String{
    printLog("needDate:\(date)")
    if date == "" || date == "0"{
        return ""
    }
    if date != "" && date != "0"{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let needFormatDate = dateFormatter.date(from: date)
        if needFormatDate == nil {
            return ""
        }
        dateFormatter.dateFormat = "M月"
        return dateFormatter.string(from: needFormatDate!)
    }else{
        return ""
    }
}

//仅显示日期
func formateDateShowDay(_ date:String) -> String{
    printLog("needDate:\(date)")
    if date == "" || date == "0"{
        return ""
    }
    if date != "" && date != "0"{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let needFormatDate = dateFormatter.date(from: date)
        if needFormatDate == nil {
            return ""
        }
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: needFormatDate!)
    }else{
        return ""
    }
}

func formatDateCountDown(date: String) -> String {
    printLog("needDate:\(date)")
    if date == "" || date == "0"{
        return ""
    }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let nowDate = Date()
    printLog("nowDate:\(nowDate)")
    let needFormatDate = dateFormatter.date(from: date)
    if let needFormatDate = needFormatDate {
        if needFormatDate < nowDate {
            return ""
        }
        let time = needFormatDate.timeIntervalSince(nowDate)
        printLog("time:\(time)")
        if time < 60*60{
            let mins = Int.init(time/60).description + "分钟后过期"
            return mins
        }else if time < 60*60*24{
            let hours = Int.init(time/60/60).description + "小时后过期"
            return hours
        }else {
            let day = Int.init(time/60/60/24).description + "天后过期"
            return day
        }
    }else {
        return ""
    }
    
}

func intervalTime(_ endTime :String) -> Int {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let nowDate = Date()
    let needFormatDate = dateFormatter.date(from: endTime)
    let time = needFormatDate!.timeIntervalSince(nowDate)
    print("time******\(time)")
    // 保证显示格式为09:01
    
    return Int(time)
}

func converToMinte(_ time :Int) -> String {
    let minStr = Int(time / 60) < 10 ? ("0" + Int(time / 60).description):Int(time / 60).description
    let secondStr = Int(time % 60) < 10 ? ("0" + Int(time % 60).description):Int(time % 60).description
    return minStr + ":" + secondStr
}

//func formateDateLogogram(date:String) -> String{
//    printLog("needDate:\(date)")
//    let dateFormatter = NSDateFormatter()
//    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//    let nowDate = NSDate()
//    printLog("nowDate:\(nowDate)")
//    let needFormatDate = dateFormatter.dateFromString(date)
//    let time = nowDate.timeIntervalSinceDate(needFormatDate!)
//    if time < 60*60{
//        let mins = Int.init(time/60).description + "分钟前"
//        return mins
//    }else if time < 60*60*24{
//        let hours = Int.init(time/60/60).description + "小时前"
//        return hours
//    }else{
//        dateFormatter.dateFormat = "MM月dd日"
//        return dateFormatter.stringFromDate(needFormatDate!)
//    }
//}

//年月日显示
func formateDateShowYear(_ date:String) -> String{
    printLog("needDate:\(date)")
    if date == "" || date == "0"{
        return ""
    }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let nowDate = Date()
    printLog("nowDate:\(nowDate)")
    let needFormatDate = dateFormatter.date(from: date)
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: needFormatDate!)
}

//日期或时间显示
func formateDateShowDateOrTime(_ date:String) -> String{
    printLog("needDate:\(date)")
    if date == "" || date == "0"{
        return ""
    }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let nowDate = Date()
    printLog("nowDate:\(nowDate)")
    let needFormatDate = dateFormatter.date(from: date)
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let needDataString = dateFormatter.string(from: needFormatDate!)
    let nowDateString = dateFormatter.string(from: nowDate)
    
    if needDataString == nowDateString {
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: needFormatDate!)
    }else{
        dateFormatter.dateFormat = "MM-dd"
        return dateFormatter.string(from: needFormatDate!)
    }
    
//    let time = nowDate.timeIntervalSinceDate(needFormatDate!)
//    if time < 60*60*24{
//        dateFormatter.dateFormat = "HH:mm"
//        return dateFormatter.stringFromDate(needFormatDate!)
//    }else{
//        dateFormatter.dateFormat = "MM月dd日"
//        return dateFormatter.stringFromDate(needFormatDate!)
//    }
}

func circleOfTeaFriendsDateShow(_ date: String) -> String {
    printLog("needDate:\(date)")
    if date == "" || date == "0"{
        return ""
    }
    var dateFormatter: DateFormatter?
    if dateFormatter == nil {
        dateFormatter = DateFormatter()
    }
    dateFormatter?.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let nowDate = Date()
    printLog("nowDate:\(nowDate)")
    let needFormatDate = dateFormatter?.date(from: date)
    printLog("date:\(date)")
    printLog("needFormatDate:\(String(describing: needFormatDate))")
    let time = nowDate.timeIntervalSince(needFormatDate!)
    printLog("time:\(time)")
    if time < 60*60{
        let mins = Int.init(time/60).description + "分钟前"
        printLog("mins:\(mins)")
        return mins
    }else if time < 60*60*24{
        let hours = Int.init(time/60/60).description + "小时前"
        printLog("hours:\(hours)")
        return hours
    }else if time < 60*60*24*7{
        let day = Int.init(time/60/60/24).description + "天前"
        printLog("day:\(day)")
        return day
    }else{
        dateFormatter?.dateFormat = "MM-dd HH:mm"
        let date = dateFormatter?.string(from: needFormatDate!)
        
        printLog("date:\(String(describing: date))")
        return date!
//        return dateFormatter.stringFromDate(needFormatDate!)
    }
}

//倒计时
func DateCountdownShow(_ startDate:String, endDate:String) -> String{
    printLog("startDate:\(startDate)")
    if startDate == "" || startDate == "0"{
        return ""
    }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    printLog("endDate:\(endDate)")
    let startFormatDate = dateFormatter.date(from: startDate)
    let endFormatDate = dateFormatter.date(from: endDate)
    let time = endFormatDate!.timeIntervalSince(startFormatDate!)
    if time < 60*60*24{
        let date = Date(timeIntervalSinceReferenceDate: time)
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }else{
        let day = Int.init(time/60/60/24).description + "天"
        return day
    }
}

func formateMouthAndDay(_ date:String) -> String {
    printLog("needDate:\(date)")
    if date == "" || date == "0"{
        return ""
    }
    if date != "" && date != "0"{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let needFormatDate = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "MM/dd"
        return dateFormatter.string(from: needFormatDate!)
    }else{
        return ""
    }
}

func configre(_ str :String) -> String {
    if str == "" || str == "0"{
        return ""
    }
    let data = (str as NSString)
    var result = ""
    if str.length == 10{ // "2015-10-10(只有年月日)"
        var month  = data.substring(with: NSMakeRange(5, 2)) as NSString
        var day = data.substring(from: str.length - 2) as NSString
        
        if month.substring(to: 1) == "0"{
            month = month.substring(from: month.length - 1) as NSString
            print(month)
        }
        
        if day.substring(to: 1) == "0"{
            day = day.substring(from: day.length - 1) as NSString
            print(day)
        }
        
        result = (month as String) + "月" + (day as String) + "日"
    }
    return result
}

 //生成网络请求的参数 params
func createParams(_ commond :String, data :[String: AnyObject]) -> [String: AnyObject] {
    if data.isEmpty {
        var params = data
        params = [COMMAND_KEY:commond as AnyObject, PLATFORM_KEY:PLATFORM_VALUE as AnyObject]
        return params
    }else{
        var dataJson = data
        dataJson[COMMAND_KEY] = commond as AnyObject?
        dataJson[PLATFORM_KEY] = PLATFORM_VALUE as AnyObject?
        let dataString = String.toJsonString(dataJson as NSDictionary)
        let params = [COMMAND_KEY:commond, PLATFORM_KEY:PLATFORM_VALUE, DATA_KEY:dataString]
        return params as [String : AnyObject]
    }
}


//let params = ["userId":userId, "type":type]
func payForJiangxiBank<T : HttpDataBaseMapModel >(_ view :UIView?,params:[String: Any],hostType : addressType = addressType.readAddress,flag:Bool = true,complation:@escaping (HttpDataMapModel<T>) -> Void) {
    HttpRequestFactory().httpRequestFuction("payJiangXi", view: view, params: params) { (result:HttpDataMapModel<T>) in
        complation(result)
    }
}

//获取通联个人状态信息
func queryTongLianUserInfo<T : HttpDataBaseMapModel >(_ view :UIView?,params:[String: Any],hostType : addressType = addressType.readAddress,flag:Bool = true,complation:@escaping (HttpDataMapModel<T>) -> Void) {
    HttpRequestFactory().httpRequestFuction("queryTongLianUserInfo", view: view, params: params) { (result:HttpDataMapModel<T>) in
        complation(result)
    }
}

//保存通联信息
func saveTongLianUserInfo(userInfo: TongLianUserInfoDataModel) {
    let userDefault = UserDefaults.standard
    userDefault.setValue(userInfo.telephone, forKey: TongLianTelePhone)
    userDefault.setValue(userInfo.name, forKey: TongLianRealName)
    userDefault.setValue(userInfo.identityNo, forKey: TongLianIdentityNo)
    userDefault.setValue(userInfo.contractNo, forKey: TongLianContractNo)
    userDefault.synchronize()
}

//设置圆形图片
func setCirclePhoto(_ imageView: UIImageView, radius: CGFloat) {
    imageView.layer.cornerRadius = radius
    imageView.layer.borderColor = UIColor.colorForHexadecimal(0xdfdede, alpha: 1).cgColor
    imageView.layer.borderWidth = 0.5
    imageView.layer.masksToBounds = true
}

func configureTF(_ title: String,textField:UITextField){
    let labelView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 20) )
    let label = UILabel(frame: CGRect(x: 10, y: 0, width: 80, height: 20))
    label.text = title
    label.font = UIFont.systemFont(ofSize: 15)
    label.textAlignment = .left
    labelView.addSubview(label)
    textField.leftView = labelView
    textField.tintColor = buttonBgColor
    textField.leftViewMode = .always
}

//加密显示银行卡号
func configureCardNum(_ str :String) -> String{
    if str.length >=  11{
        let preStr = str.substring(to: str.characters.index(str.startIndex, offsetBy: str.length - 4))
        let result =  preStr.characters.flatMap({_ in
            return "*"
        })
        return result.joined(separator: "") + str.substring(from: str.characters.index(str.endIndex, offsetBy: -4))
    }else{
        return ""
    }
}

//加密显示手机号和身份证号
func configureIDAndPhone(_ str :String) -> String{
    
//    let preStr = str.substringToIndex(str.startIndex.advancedBy(str.length - 4))
    if str.length >= 11{
        let startIndex = str.characters.index(str.startIndex, offsetBy: 3)
        let endIndex = str.characters.index(str.endIndex, offsetBy: -4)
//        let range = Range(start: startIndex, end: endIndex)
        let range = Range(startIndex ..< endIndex)
        
        let replaceStr = str.substring(with: range)
    
        let result =  replaceStr.characters.flatMap({_ in
            return "*"
        })
        return str.substring(to: str.characters.index(str.startIndex, offsetBy: 3)) + result.joined(separator: "") + str.substring(from: str.characters.index(str.endIndex, offsetBy: -4))
    }else{
        return ""
    }
}

func storeImg(_ path :String,imgData :Data) {
    var cachePath = NSHomeDirectory() + "/Library/Caches/MyCache/"
    print(NSHomeDirectory())
    print("cachePath:  \(cachePath)")
    let fileManager  = FileManager.default
    if !fileManager.fileExists(atPath: cachePath){
      try! fileManager.createDirectory(atPath: cachePath, withIntermediateDirectories: true, attributes: nil)
    }
    cachePath = cachePath + path
    if (try? imgData.write(to: URL(fileURLWithPath: cachePath), options: [.atomic])) != nil {
        print("写入数据成功")
    }else{
        print("写入数据失败")
    }
}

func loadImg(_ path :String,imageView :UIImageView){
    var cachePath = NSHomeDirectory() + "/Library/Caches/MyCache/"
    print(NSHomeDirectory())
    cachePath = cachePath + path
    print(cachePath)
    var data :Data?
    if FileManager.default.fileExists(atPath: cachePath){
    data = try? Data(contentsOf: URL(fileURLWithPath: cachePath))
    }
    if data != nil{
    print("读入数据不为空")
    imageView.image = UIImage(data: data!)
    }else{
    imageView.image = UIImage(named: "personal_pic")
    print("读入数据为空")
    }
}

////判断邮箱格式
//  func validateEmail(email :String?) -> Bool {
//
//    if email == ""{
//    return false
//    }
//
//    let predicateStr = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
//    let predicate =  NSPredicate(format: "SELF MATCHES %@" ,predicateStr)
//    return predicate.evaluateWithObject(predicate)
//}

//获取tea详情数据 buy
func initNetWorkAddress<T>(_ command : String,view :UIView?,params:[String: Any],hostType : addressType = addressType.readAddress,flag:Bool = true,complation:@escaping (HttpDataMapModel<T>) -> Void){
    
    PostRequestsFactory.createJsonRequest("", params: Dictionary(), hostType: addressType.initAddress, encrypt: false).sendRequestWithCompletion({ (response :Result <InitData>) -> Void in
        let response = response.value
        
        if response == nil {
            printLog("网络连接有问题")
            return
        }
        printLog("statusCode:\(response!.statusCode)")
        printLog(response!.getJsonString())//打印出data
        switch response!.statusCode{
        case HttpStatusCode.code_Success.rawValue:
            printLog("@@@@@@@@@@appAddress:\(String(describing: response?.data?.appAddress))")
            // 拿到初始化请求初始化网络地址
            let userDefaults = UserDefaults.standard
            userDefaults.setValue((response?.data?.appAddress)!, forKey: APPADDRESS)//设置为非首次打开
            userDefaults.setValue((response?.data?.uploadImageAddress)!, forKey: UploadImageAddress)
            userDefaults.setValue((response?.data?.pinganResultAddress)!, forKey: PinganResultAddress)
            userDefaults.setValue(changeToHttps((response?.data?.pinganResultAddress)!), forKey: PinganResultHttpsAddress)
            userDefaults.setValue((response?.data?.shareDownloadAddress)!, forKey: ShareDownloadAddress)
            userDefaults.setValue((response?.data?.registrationAgreement)!, forKey: RegistrationAgreement)
            userDefaults.setValue((response?.data?.contactContractTemplate)!, forKey: ContactContractTemplate)
            userDefaults.setValue((response?.data?.newTeabookingInstructions)!, forKey: NewTeabookingInstructions)
            userDefaults.setValue((response?.data?.preAndNowTeaContract)!, forKey: PreAndNowTeaContract)
            userDefaults.setValue((response?.data?.storageCharges)!, forKey: StorageCharges)
            userDefaults.setValue((response?.data?.ogisticsRulesAndIntroduction)!, forKey: OgisticsRulesAndIntroduction)
            userDefaults.setValue((response?.data?.warehousingLogisticsServiceAgreement)!, forKey: WarehousingLogisticsServiceAgreement)
            userDefaults.setValue((response?.data?.warehouseIntroduction)!, forKey: WarehouseIntroduction)
            userDefaults.setValue((response?.data?.packagingCharges)!, forKey: PackagingCharges)
            userDefaults.setValue(response?.data?.transportationFeeRules, forKey: TransportationFeeRules)
            
            userDefaults.setValue(response?.data?.shopAppAddress, forKey: ShopAppAddress)
            userDefaults.setValue(response?.data?.shopQrAddress, forKey: ShopQrAddress)
            
            //新年首页的图片
            userDefaults.setValue((response?.data?.newYearBanner), forKey: NewYearBannerImgAddr)
            userDefaults.setValue((response?.data?.newYearBuyTea), forKey: NewYearBuyTeaImgAddr)
            userDefaults.setValue((response?.data?.newYearSellTea), forKey: NewYearSellTeaImgAddr)
            userDefaults.setValue((response?.data?.newYearNewTea), forKey: NewYearNewTeaImgAddr)
            userDefaults.setValue((response?.data?.newYearLaunchPage), forKey: NewYearLanuchImgAddr)
            userDefaults.setValue(response?.data?.invoiceInstruction, forKey: InvoiceInstruction)
            
            userDefaults.setValue((response?.data?.addCardDescription)! , forKey: AddCardDescription)
            userDefaults.setValue((response?.data?.myAccountDescription)! , forKey: MyAccountDescription)
            userDefaults.setValue((response?.data?.openAccountProtocol)!, forKey: OpenAccountProtocol)
            userDefaults.setValue((response?.data?.autoBuyProtocol)!, forKey: AutoBuyProtocol)
            userDefaults.setValue((response?.data?.openAccountDescription)!, forKey: OpenAccountDescription)
            
            userDefaults.setValue(response?.data?.userLicenseAgreement, forKey: UserLicenseAgreement)
            userDefaults.setValue(response?.data?.jiangxiBankNetworkTransactionCapitalAccountServicesTripartiteAgreement, forKey: JXNetworkTransactionCapitalAccountServicesTripartiteAgreement)
            userDefaults.setValue(response?.data?.shopServiceRules, forKey: ShopServiceRules)
            userDefaults.setValue(response?.data?.nowTeaDealContract, forKey: NowTeaDealContract)
            userDefaults.setValue(response?.data?.preTeaDealContract, forKey: PreTeaDealContract)
            
            userDefaults.setValue(response?.data?.buyingDescription, forKey: BuyingDescription)
            userDefaults.setValue(response?.data?.buyingList, forKey: BuyingList)
            userDefaults.setValue(response?.data?.buyingInfo, forKey: BuyingInfo)
            userDefaults.setValue(response?.data?.buyingPublish, forKey: BuyingPublish)
            
            userDefaults.synchronize()
            HttpRequestFactory().httpRequestFuction(command, view: view, params: params, complation: { (result:HttpDataMapModel<T>) in
                
                    complation(result)
            })
            break
        default :
            //MBHUDManager.sharedInstance.customShow(view!, addText: result!.msg)
            printLog("默认请求出错")
            break
        }

    })
}

func setCellViewShadow(_ view:UIView) {
    view.layer.masksToBounds = false
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.cornerRadius = 3
    view.layer.shadowRadius = 2
    view.layer.shadowOffset = CGSize(width: 0, height: 0);
    view.layer.shadowOpacity = 0.2
}

func setShaowView(_ view :UIView){
    view.layer.cornerRadius = 3
    view.layer.shadowOpacity = 0.1
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOffset = CGSize(width: 1, height: 1)
    view.layer.shadowRadius = 3
}

func settingCodeType() -> Int{
    
    let userDefault = UserDefaults.standard
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let dateString = formatter.string(from: date)
    print("\(dateString)")
    //let dates:[String] = dateString.componentsSeparatedByString("-")
    let currentDay = userDefault.string(forKey: Current_Day)
    print(currentDay ?? "")
    // 如果是新的一天 则重置
    if dateString != currentDay{
        userDefault.set(0, forKey: Index_One)
        userDefault.set(0, forKey: Index_Two)
        userDefault.setValue(dateString, forKey: Current_Day)
        userDefault.synchronize()
    }
    
    var indexOne = userDefault.integer(forKey: Index_One)
    var indexTwo = userDefault.integer(forKey: Index_Two)
    
    if indexTwo >= 6 {
        indexTwo = 0
        indexOne = indexOne + 1
    }else{
        indexTwo = indexTwo + 1
    }
    
    print("indexOne*****\(indexOne)****indexTwo****\(indexTwo)")
    userDefault.set(indexOne, forKey: Index_One)
    userDefault.set(indexTwo, forKey: Index_Two)
    userDefault.synchronize()
    return indexOne
}

func changeToHttps(_ url:String) -> String {
    let httpsString = url.replacingOccurrences(of: "http://", with: "https://")
    printLog("httpsString:\(httpsString)")
    return httpsString
}

//http转换为https
func transfromOfHttpsAndHttp() -> TransformOf<String, String> {
    return TransformOf<String, String>.init(fromJSON: { (JSONString) -> String? in
        //            let httpsString = url.stringByReplacingOccurrencesOfString("http://", withString: "https://")
        if var str = JSONString{
            str = str.replacingOccurrences(of: "http://", with: "https://")//str.stringByReplacingOccurrencesOfString("http://", withString: "https://")
            return str
        }else{
            return ""
        }
        }, toJSON: {
            $0.map { String($0) }
    })
}

func transfromOfPicUrlFromCnToEn() -> TransformOf<String, String> {
    return TransformOf<String, String>.init(fromJSON: { (JSONString) -> String? in
        //            let httpsString = url.stringByReplacingOccurrencesOfString("http://", withString: "https://")
        if var str = JSONString{
            str = str.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!//str.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())!
            return str
        }else{
            return ""
        }
        }, toJSON: {
            $0.map { String($0) }
    })
}

//退出登录数据处理
func logoutResetData() {
    QYSDK.shared().logout(nil)
    
    do {
        let realm = try Realm()
        try realm.write{
            realm.deleteAll() //推出登录删除所有数据
            printLog("退出登录")
        }
    }catch let error as NSError {
        printLog(error)
    }catch{
        
    }
    //退出登录时候，，把所有的数据都删除，，然后再把有用的存起来
    let fields = [REGISTRATION_ID,
                  APPADDRESS,
                  NOT_FIRST_OPENED_V3,
                  UploadImageAddress,
                  Index_One,
                  Current_Day,
                  PinganResultAddress,
                  PinganResultHttpsAddress,
                  ShareDownloadAddress,
                  RegistrationAgreement,
                  ContactContractTemplate,
                  NewTeabookingInstructions,
                  PreAndNowTeaContract,
                  StorageCharges,
                  OgisticsRulesAndIntroduction,
                  WarehousingLogisticsServiceAgreement,
                  WarehouseIntroduction,
                  PackagingCharges,
                  TransportationFeeRules,
                  NewYearBannerImgAddr,
                  NewYearBuyTeaImgAddr,
                  NewYearSellTeaImgAddr,
                  NewYearNewTeaImgAddr,
                  NewYearLanuchImgAddr,
                  ShopAppAddress,
                  ShopQrAddress,
                  AddCardDescription,
                  MyAccountDescription,
                  OpenAccountProtocol,
                  AutoBuyProtocol,
                  OpenAccountDescription,
                  First_Enter_Account,
                  ShowDelegateView,
                  ShowDelegateFeeView,
                  ShowDelegateMarketDeal,
                  ShowDelegateNewTea,
                  UserLicenseAgreement,
                  JXNetworkTransactionCapitalAccountServicesTripartiteAgreement,
                  ShopServiceRules,
                  NowTeaDealContract,
                  PreTeaDealContract,
                  BuyingDescription,
                  BuyingList,
                  BuyingInfo,
                  BuyingPublish,
                  ShowDelegateAskToBuyTea]
    
    let userDataModel = UserDefaultDataModel()
    let dataS = userDataModel.getData(fields)
    //删除nsuserdefault 存储的所有值
    let userdefault = UserDefaults.standard
//    let noFirst = userdefault.stringForKey(First_Enter_Account)
//    print("noFirst: \(noFirst)")
    let appDomin = Bundle.main.bundleIdentifier
    userdefault.removePersistentDomain(forName: appDomin!)
    userdefault.set(false, forKey: IS_LOGIN)
//    userdefault.setValue(noFirst, forKey: First_Enter_Account)
    userdefault.synchronize()
    userDataModel.dataStore(fields, datas: dataS)
}

// money显示格式转换 例如 33445566.99 显示为3344.5万
func moneyFormatSetting(_ money :String) -> String{
    let moneyStr = money as NSString
    if moneyStr.length >= 6{
        //let moneyS = moneyStr.substringToIndex(moneyStr.length - 6) as NSString
        let moneyS = moneyStr.components(separatedBy: ".").first! as NSString
        var result = ""
        if moneyS.length >= 5{
            result = moneyS.substring(to: moneyS.length - 4) + "." + moneyS.substring(with: NSMakeRange(moneyS.length - 4, 1)) + "万"
        }else{
            result = "0." + moneyS.substring(to: 1)
        }
        return result
    }else{
        print("请输入合法的money数")
        return money
    }
}

func setTeaNumber(_ sliceNumber:String, pieceNumber:String) -> String {
    var teaNumber = ""
    if pieceNumber != "0" && sliceNumber != "0" && pieceNumber != "" && sliceNumber != "" {
        teaNumber = attributeText(pieceNumber, suffix: "件", prefix: false) + attributeText(sliceNumber, suffix: "片", prefix: false)
    }else if sliceNumber != "0" && sliceNumber != "" {
        teaNumber = attributeText(sliceNumber, suffix: "片", prefix: false)
    }else if pieceNumber != "0" && pieceNumber != "" {
        teaNumber = attributeText(pieceNumber, suffix: "件", prefix: false)
    }
    return teaNumber
}

func setTeaType(_ teaType:String) -> String {
    var teaTypeCN = ""
    if teaType == Raw_Tea {
        teaTypeCN = "生茶"
    }else if teaType == Fermented_Tea {
        teaTypeCN = "熟茶"
    }
    printLog("teaTypeCN:\(teaTypeCN)")
    return teaTypeCN
}

func isValidateEmail(_ email : String) -> Bool{
    do {
        let pattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let matches = regex.matches(in: email, options: .reportProgress, range: NSMakeRange(0, email.length))
        return matches.count > 0
    }catch {
        return false
    }
}




