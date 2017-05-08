//
//  SearchVC.swift
//  TravelSwift
//
//  Created by iMac on 17/5/3.
//  Copyright © 2017年 iMac. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = kMainColor;
        creatBackBtn();
        
    }
    
    func creatBackBtn()  {
        let backBtn = UIButton(type: .custom);
        backBtn.frame = CGRect(x: 10, y: 20, width: 30, height: 30);
        backBtn.setImage(UIImage(named:"back"), for: .normal);
        backBtn.addTarget(self, action: #selector(SearchVC.backAction), for: .touchUpInside);
        self.view.addSubview(backBtn);
    }
    
    func backAction()  {
        self.dismiss(animated: true, completion: nil);
    }
}
