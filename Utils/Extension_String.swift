//
//  Extension_String.swift
//  Tea
//
//  Created by houqinghui on 2016/10/27.
//  Copyright © 2016年 chengdachenshengbao. All rights reserved.
//

import UIKit

//扩展String
extension  String {
    // readonly computed property
    var length: Int {
        return self.characters.count
    }
    /**
     判断一个string是否是一个有效的手机号（在大陆）
     :param: phoneNumber 手机号码的字符串
     :returns: bool值标示手机号
     */
    static func isValidatePhoneNumber(_ phoneNumber:NSString)->Bool
    {
        switch phoneNumber {
        case let phone where (phone as NSString).length != 11:   //手机号不等于11位
            return false
        default:
            let mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
            let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
            let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
            let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
            let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
            let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
            let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
            let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
            if ((regextestmobile.evaluate(with: phoneNumber) == true)
                || (regextestcm.evaluate(with: phoneNumber)  == true)
                || (regextestct.evaluate(with: phoneNumber) == true)
                || (regextestcu.evaluate(with: phoneNumber) == true))
            {
                return true
            }
            else
            {
                return false
            }
        }
    }
    //产生带“－”的uuid
    static func generate36UUID()-> String {
        return UUID().uuidString
    }
    /**
     产生32位的uuid
     :returns: 32位的uuid
     */
    static func generate32UUID()-> String {
        return UUID().uuidString.replacingOccurrences(of: "-", with: "")
    }
    /**
     判断是否为数
     :param: string 参数为一个字符串
     :returns: 返回bool值
     */
    static func isNumber (_ string :String) -> Bool{
        if !string.isEmpty && (string as NSString).substring(to: 1) != "0" {
            for char in string.utf8 {
                if (char > 47 && char < 58){
                }else {
                    printLog("含有特殊字符")
                    return false
                }
            }
        }else {
            return false
        }
        return true
    }
    //字典转json字符串
    static func toJsonString(_ dic :NSDictionary) -> String{
        let dataStr = try! JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted)
        let dataJson = String(data: dataStr, encoding: String.Encoding.utf8)
        return dataJson!
    }
    
    func convertStringToDictionary(_ text: String) -> [String: AnyObject]? {
//        if let data = text.data(using: String.Encoding.utf8) {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
//                return try JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.init(rawValue: 0)]) as? [String:AnyObject]
                return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:AnyObject]
            } catch let error as NSError {
                printLog(error)
            }
        }
        return nil
    }
    
    static func toInt(_ str :String) -> Int{
        let strInt = (str as NSString).integerValue
        return strInt
    }
    
    static func toFloat(_ str :String) -> Float{
        let strInt = (str as NSString).floatValue
        return strInt
    }
    
    func pinyin() -> String{
        let str : CFMutableString = self.mutableCopy as! CFMutableString
        printLog("str:\(str)")
        if CFStringTransform(str as CFMutableString, nil, kCFStringTransformMandarinLatin, false) {
            if CFStringTransform(str as CFMutableString, nil, kCFStringTransformStripDiacritics, false) {
                let string = (str as String).replacingOccurrences(of: " ", with: "")
                printLog("汉字的拼音1：\(string)")
                return string
            }
        }
        printLog("汉字的拼音：\(str)")
        return str as String
    }
    
    //判断昵称格式
    static func isValidateNickName(_ nickName:String) -> Bool {
        let passwordRegularExpression = try! NSRegularExpression.init(pattern: "^[0-9a-zA-Z\\u4e00-\\u9fa5]{1,6}$", options: NSRegularExpression.Options.caseInsensitive)
        let result = passwordRegularExpression.matches(in: nickName, options: .reportProgress, range: NSMakeRange(0, nickName.length))
        printLog("count:\(result.count)")
        if result.count == 0 {
            return false
        }else{
            return true
        }
    }
    
    //判断密码格式
    static func isValidatePassword(_ password:String) -> Bool {
        let nickNameRegularExpression = try! NSRegularExpression.init(pattern: "^[0-9a-zA-Z]{6,15}$", options: NSRegularExpression.Options.caseInsensitive)
        let nickNameResult = nickNameRegularExpression.matches(in: password, options: .reportProgress, range: NSMakeRange(0, password.length))
        if nickNameResult.count == 0 {
            return false
        }else{
            return true
        }
    }
    
    //判断字母和数字格式
    static func isValidateLetterOrNumber(_ password:String) -> Bool {
        let nickNameRegularExpression = try! NSRegularExpression.init(pattern: "^[0-9a-zA-Z]+$", options: NSRegularExpression.Options.caseInsensitive)
        let nickNameResult = nickNameRegularExpression.matches(in: password, options: .reportProgress, range: NSMakeRange(0, password.length))
        if nickNameResult.count == 0 {
            return false
        }else{
            return true
        }
    }
    
    //md5加密算法
    func getMd5() -> String {
        let str = self.cString(using: .utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: .utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deallocate(capacity: digestLen)
        
        return String(hash)
    }
}
