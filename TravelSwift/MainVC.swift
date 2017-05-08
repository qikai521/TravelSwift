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
        self.automaticallyAdjustsScrollViewInsets = false;
        self.title = "UOU";
        creatNaviItem();
    }
    
    func creatNaviItem() {
        let leftBtn = UIBarButtonItem(image: UIImage(named:"定位"), style: .done, target: self, action: #selector(MainVC.enterLocation));
        leftBtn.tintColor = kMainColor;
        self.navigationItem.setLeftBarButton(leftBtn, animated: false);
        
        let banner = MainBannerView(frame: CGRect(x: 0, y: 100, width: kScreenWidth, height: 250));
        banner.bannerScroll?.setBannerImgWithUrls(urls: ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493877723278&di=5d7a0c8821392bd4879a02711fb3fd96&imgtype=0&src=http%3A%2F%2Ffile27.mafengwo.net%2FM00%2FB2%2F12%2FwKgB6lO0ahWAMhL8AAV1yBFJDJw20.jpeg","https://image.baidu.com/search/detail?ct=503316480&z=0&ipn=d&word=tup&step_word=&hs=2&pn=0&spn=0&di=109175798270&pi=0&rn=1&tn=baiduimagedetail&is=0%2C0&istype=0&ie=utf-8&oe=utf-8&in=&cl=2&lm=-1&st=undefined&cs=2277942808%2C1417432970&os=4089470354%2C3682420300&simid=3367746412%2C283397473&adpicid=0&lpn=0&ln=1972&fr=&fmq=1493867638606_R&fm=&ic=undefined&s=undefined&se=&sme=&tab=0&width=undefined&height=undefined&face=undefined&ist=&jit=&cg=&bdtype=0&oriquery=&objurl=http%3A%2F%2Fb3-q.mafengwo.net%2Fs10%2FM00%2F44%2F54%2FwKgBZ1h7JMaAc8PeAAFC76SybfM74.jpeg%3FimageView2%2F2%2Fw%2F600%2Fh%2F600%2Fq%2F90&fromurl=ippr_z2C%24qAzdH3FAzdH3Fnma_z%26e3B4wujg2o5_z%26e3BvgAzdH3Fp6wejsfAzdH3Ftgu5_z%26e3Brir%3Ft1%3Dmc0bl8b&gsm=0&rpstart=0&rpnum=0","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493877787644&di=d6a3a6ab7d4f8ba8ec8af9bcca9d78c6&imgtype=0&src=http%3A%2F%2Fexp.cdn-hotels.com%2Fhotels%2F4000000%2F3900000%2F3893200%2F3893187%2F3893187_25_y.jpg"]) { (index) in
            print(index);
        }
        self.view.addSubview(banner);
    }
    
    //进入定位界面
    
    func enterLocation()  {
        print("进入定位界面");                                                                                                                                                                                                                                                        
    }
    
}
