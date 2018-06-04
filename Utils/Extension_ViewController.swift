//
//  Extension_ViewController.swift
//  store
//
//  Created by houqinghui on 16/8/25.
//  Copyright © 2016年 chengda. All rights reserved.
//

import Foundation

enum navigationState{
    case back_title // 返回和title同时存在
    case back       // 只有返回
    case title      // 只有title
    case all        // 返回和title和右边功能键都存在
    case title_right  // 右边按钮和title同时存在
    case back_right  // 右边按钮和返回同时存在
}

extension UIViewController{
    // state 枚举变量
    func settingNavigationBar(_ titleStr :String, state : navigationState = .back_title, rightTitle : String = ""){
        
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: false)
        
        if self.navigationItem.leftBarButtonItem != nil{
            self.navigationItem.leftBarButtonItem = nil
            self.navigationItem.leftBarButtonItem = UIBarButtonItem()
            self.navigationItem.setHidesBackButton(true, animated: false)
        }
//        self.preferredStatusBarStyle {
//            return UIStatusBarStyle.lightContent
//        }
        //返回button
        let btn = UIButton(frame:CGRect(x: 0, y: 0, width: 22, height: 44))
        btn.setImage(UIImage(named: "back") , for: UIControlState())
        btn.addTarget(self, action: #selector(back), for: UIControlEvents.touchUpInside)
        let barBtn = UIBarButtonItem(customView: btn)
        
        self.navigationItem.leftBarButtonItem?.image = UIImage(named: "back")
        
        // 中间titleview
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        title.text = titleStr
        title.textAlignment = NSTextAlignment.center
        title.textColor = UIColor.white
        titleView.addSubview(title)
        
        // 右上角button
        let rightButton = UIBarButtonItem(title: rightTitle, style: .plain, target: self, action: #selector(rightBarButtonAction))
        rightButton.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.white], for: UIControlState())
        rightButton.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 14)], for:UIControlState())
        self.navigationController?.navigationBar.backgroundColor = mainRedColor
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = mainRedColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barStyle = .black
        //枚举判断不同的状态
        switch state {
        case .back_title:
            self.navigationItem.leftBarButtonItem = barBtn
            self.navigationItem.titleView = titleView
            break
        case .back:
            self.navigationItem.leftBarButtonItem = barBtn
            break
        case .title:
            self.navigationItem.titleView = titleView
            self.navigationItem.hidesBackButton = true
            break
        case .all:
            self.navigationItem.leftBarButtonItem = barBtn
            self.navigationItem.titleView = titleView
            self.navigationItem.rightBarButtonItem = rightButton
            break
        case .title_right:
            self.navigationItem.titleView = titleView
            self.navigationItem.hidesBackButton = true
            self.navigationItem.rightBarButtonItem = rightButton
            break
        case .back_right:
            self.navigationItem.leftBarButtonItem = barBtn
            self.navigationItem.rightBarButtonItem = rightButton
            break
        }
    }
    
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setRightBarButton() {
    }
    
    func rightBarButtonAction() {
        printLog("rightBarButtonAction")
    }
    
    func uMengStatisticIn(){
        let className = self.classForCoder.description()
        let array = className.components(separatedBy: ".")
        print("\(array[1])")
        MobClick.beginLogPageView(array[1])
    }
    
    func uMengStatisticOff(){
        let className = self.classForCoder.description()
        let array = className.components(separatedBy: ".")
        print("\(array[1])")
        MobClick.endLogPageView(array[1])
    }
    
    // view显示出来之前，，子view的初始化工作
    func setSubView(){
    }
    
    //view显示出来之前添加手势事件
    func addGestureToView(){
    }
    
    // view显示出来之前。。 设置数据。。
    func initData(){
    }
    
//    var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    //MARK: - 返回的controller
    func backControllerAction(controller: String) {
        for item in (self.navigationController?.viewControllers)! {
            let className = item.description
            printLog("className:\(className)")
            if className.components(separatedBy: controller).count > 1 {
                self.navigationController?.popToViewController(item, animated: true)
                return
            }
        }
//        self.navigationController?.popViewController(animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "MainTabController")
        self.present(VC, animated: true, completion: nil)
    }
    
}
