//
//  color.swift
//  TravelSwift
//
//  Created by iMac on 17/5/2.
//  Copyright © 2017年 iMac. All rights reserved.
//

import UIKit
//颜色相关
public let kMainColor:UIColor = UIColor.init(colorLiteralRed: 36/255.0, green: 200/255.0, blue: 1, alpha: 1);

public let kGrayColor:UIColor = UIColor.init(colorLiteralRed: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1)

public let kGreenColor:UIColor = UIColor.init(colorLiteralRed: 78/255.0, green: 238/255.0, blue: 148/255.0, alpha: 1);

public let kLowBlueColor:UIColor = UIColor.init(colorLiteralRed: 187/255.0, green: 1, blue: 1, alpha: 1)

public let kDrakBlueColor:UIColor = UIColor.init(colorLiteralRed: 0, green: 197/255.0, blue: 205/255.0, alpha: 1)

public let kMainRedColor:UIColor = UIColor.init(colorLiteralRed: 1, green: 69/255.0, blue: 0, alpha: 1)


class ColorManager: NSObject {
    class func mainColor()->UIColor{
        return kMainColor;
    }
    
    class func getRGBColorWithRGB(r:NSInteger ,g:NSInteger, b:NSInteger, a:CGFloat) ->UIColor {
        return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: a);
    }
}
