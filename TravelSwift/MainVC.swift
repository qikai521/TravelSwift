//
//  MainVC.swift
//  TravelSwift
//
//  Created by iMac on 17/5/3.
//  Copyright © 2017年 iMac. All rights reserved.
//

import UIKit


class MainVC: BaseViewController {
    override func viewDidLoad() {
        self.title = "UOU";
        creatNaviItem();
    }
    
    func creatNaviItem() {
        let leftBtn = UIBarButtonItem(image: UIImage(named:"定位"), style: .done, target: self, action: #selector(MainVC.enterLocation));
        leftBtn.tintColor = kMainColor;
        self.navigationItem.setLeftBarButton(leftBtn, animated: false);
        
    }
    //进入定位界面
    
    func enterLocation()  {
        print("进入定位界面");
    }
    
}
