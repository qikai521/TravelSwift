//
//  UserInfo.swift
//  TravelSwift
//
//  Created by iMac on 17/5/2.
//  Copyright © 2017年 iMac. All rights reserved.
//

import UIKit

public let kUserdefault_LogModelKey:String = "kUserdefault_LogModelKey"
public let kUserdefault_isLoginKey:String = "kUserdefault_isLoginKey"

class UserModel:NSObject{
    var nickName:NSString?;
    var phone:NSString?;
    var address:NSString?;
    var age:NSInteger = 0;
    var userId:NSString?;
    var sex:Bool = true;//YES男 NO女
}

class LoginUserManager: NSObject {
    var nickName:NSString?
    var phoneNum:NSString?
    var userId:NSString?;
    var userModel:UserModel?;
    var isLogin:Bool?;
    
    static var sharedManager:LoginUserManager{
        struct Static {
            static let instance:LoginUserManager = LoginUserManager()
        }
        return Static.instance;
    }
    
    //初次登录
    func login(model:UserModel){
        userId = model.userId;
        nickName = model.nickName;
        phoneNum = model.phone;
        userModel = model;
        isLogin = true;
        UserDefaults.standard.set(userModel, forKey:kUserdefault_LogModelKey);
        UserDefaults.standard.set(true, forKey:kUserdefault_isLoginKey);
        
    }
    
    //登出
    func logout() {
        userId = nil;
        nickName = nil;
        phoneNum = nil;
        userModel = nil;
        isLogin = false;
        UserDefaults.standard.set(nil, forKey:kUserdefault_LogModelKey);
        UserDefaults.standard.set(false, forKey:kUserdefault_isLoginKey);
    }
    
    //本地判断,
    func isLoginOrNo() -> (Bool,UserModel){
        let isLogin:Bool = UserDefaults.standard.bool(forKey: kUserdefault_isLoginKey);
        var loginModel:UserModel?;
        if isLogin {
            loginModel = UserDefaults.standard.object(forKey: kUserdefault_LogModelKey) as? UserModel;
        }
        return (isLogin,loginModel!);
    }
}
