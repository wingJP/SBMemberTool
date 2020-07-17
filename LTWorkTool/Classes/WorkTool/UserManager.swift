//
//  UserManager.swift
//  SBVideoTool
//
//  Created by 王剑鹏 on 2020/6/10.
//  Copyright © 2020 Lete. All rights reserved.
//

import UIKit

let USER_UPDATE_VIPINFO_NOTIFICATION = Notification.Name(rawValue:"com.shenbi.updateVipInfo")
let IAP_FAIL_NOTIFICATION = Notification.Name(rawValue:"com.shenbi.paymentFail")
let IAP_SUCCESS_NOTIFICATION = Notification.Name(rawValue:"com.shenbi.paymentSuccess")

/// 用户管理类
public class UserManager: NSObject {
    
   public static let manager = UserManager()
    
    let USER_PAYMENT_INFO_KEY = "com.shenbi.userPaymentInfo"
    let USER_DEVSETTING_INFO_KEY = "com.shenbi.userDevSettingInfo"
    
    //是否走广告逻辑
   public var shouldShowAd:Bool{
        get{
            #if TEST
            if localDevSettingInfo["showAd"]!{
                if self.isVIP{
                    return false
                }else{
                    return true
                }
            }else{
                return false
            }
            #else
            if self.isVIP{
                return false
            }else{
                return true
            }
            #endif
        }
    }
    
    /// 是否走苹果购买逻辑
   public var shouldIAP:Bool{
        get{
            #if TEST
            if localDevSettingInfo["showIAP"]! {
                return true
            }else{
                return false
            }
            #else
            if self.isVIP{
                return false
            }else{
                return true
            }
            #endif
        }
    }
    
    /// 用户是否VIP用户
   public var isVIP:Bool{
        get{
            if localPaymentInfo["forever"] as? Bool ?? false{
                return true
            }else{
                guard let localExpires = localPaymentInfo["expiresDate"] as? Double else{return false}
                let now = NSDate().timeIntervalSince1970
                if localExpires > now{
                    return true
                }else{
                    return false
                }
            }
        }
    }
    
    /// 会员到期日期
   public var expiresDate:String{
        get{
            if localPaymentInfo["forever"] as? Bool ?? false{
                return "forever"
            }else{
                let date = Date(timeIntervalSince1970: (localPaymentInfo["expiresDate"] as? Double)!)
                let dformatter = DateFormatter()
                dformatter.dateFormat = "dataFormatter"
                return dformatter.string(from: date)
            }
        }
    }
    
    /// 更新会员到期时间
  public  func updateExpiresDate(expiresDate dateMS:Double) -> () {
        guard let localExpires = localPaymentInfo["expiresDate"] as? Double else{return}
        if dateMS > localExpires{
            localPaymentInfo["expiresDate"] = dateMS
        }
    }
    
    /// 更新永久会员状态
  public  func updateForever(buyForever forever:Bool) -> () {
        guard let localForever = localPaymentInfo["forever"] as? Bool else{return}
        if(forever != localForever){
            localPaymentInfo["forever"] = forever
        }
    }
    
    private var paymentInfo:[String:Any] = ["forever":false,"expiresDate":Double(0)]
    /// 本地会员信息
   public var localPaymentInfo:[String:Any] {
        get{
            return UserDefaults.standard.object(forKey: USER_PAYMENT_INFO_KEY) as? [String : Any] ?? paymentInfo
        }
        set{
            UserDefaults.standard.set(newValue, forKey: USER_PAYMENT_INFO_KEY)
            UserDefaults.standard.synchronize()
            DispatchQueue.main.async {
                NotificationCenter.default.post(Notification.init(name: USER_UPDATE_VIPINFO_NOTIFICATION))
            }
            
        }
    }
    
    private var devSettingInfo:[String:Bool] = ["showAd":true, "showIAP":true]
    /// 本地开发设置信息
   public var localDevSettingInfo:[String:Bool]{
        get{
            return UserDefaults.standard.object(forKey: USER_DEVSETTING_INFO_KEY) as? [String:Bool] ?? devSettingInfo
        }
        set{
            UserDefaults.standard.set(newValue, forKey: USER_DEVSETTING_INFO_KEY)
            UserDefaults.standard.synchronize()
        }
    }
}
