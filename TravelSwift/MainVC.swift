//
//  MainVC.swift
//  TravelSwift
//
//  Created by iMac on 17/5/3.
//  Copyright © 2017年 iMac. All rights reserved.
//

import UIKit


class MainVC: BaseViewController,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate {
    
    var _mainTB:UITableView = {
        let tb = UITableView(frame:CGRect(x: 0, y: 164, width: kScreenWidth, height: kScreenHeight - 164), style: UITableViewStyle.grouped);
        return tb;
    }();
    
    var _mainScrollView:UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 64.0, width: kScreenWidth, height: kScreenHeight - 64.0 - 44.0));
        return scrollView;
    }();
    
    lazy var bannerView: MainBannerView = {
        let banner = MainBannerView(frame: CGRect(x: 0, y: 100, width: kScreenWidth, height: 150));
        banner.bannerScroll?.setBannerImgWithUrls(urls: ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493877723278&di=5d7a0c8821392bd4879a02711fb3fd96&imgtype=0&src=http%3A%2F%2Ffile27.mafengwo.net%2FM00%2FB2%2F12%2FwKgB6lO0ahWAMhL8AAV1yBFJDJw20.jpeg","https://image.baidu.com/search/detail?ct=503316480&z=0&ipn=d&word=tup&step_word=&hs=2&pn=0&spn=0&di=109175798270&pi=0&rn=1&tn=baiduimagedetail&is=0%2C0&istype=0&ie=utf-8&oe=utf-8&in=&cl=2&lm=-1&st=undefined&cs=2277942808%2C1417432970&os=4089470354%2C3682420300&simid=3367746412%2C283397473&adpicid=0&lpn=0&ln=1972&fr=&fmq=1493867638606_R&fm=&ic=undefined&s=undefined&se=&sme=&tab=0&width=undefined&height=undefined&face=undefined&ist=&jit=&cg=&bdtype=0&oriquery=&objurl=http%3A%2F%2Fb3-q.mafengwo.net%2Fs10%2FM00%2F44%2F54%2FwKgBZ1h7JMaAc8PeAAFC76SybfM74.jpeg%3FimageView2%2F2%2Fw%2F600%2Fh%2F600%2Fq%2F90&fromurl=ippr_z2C%24qAzdH3FAzdH3Fnma_z%26e3B4wujg2o5_z%26e3BvgAzdH3Fp6wejsfAzdH3Ftgu5_z%26e3Brir%3Ft1%3Dmc0bl8b&gsm=0&rpstart=0&rpnum=0","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493877787644&di=d6a3a6ab7d4f8ba8ec8af9bcca9d78c6&imgtype=0&src=http%3A%2F%2Fexp.cdn-hotels.com%2Fhotels%2F4000000%2F3900000%2F3893200%2F3893187%2F3893187_25_y.jpg"]) { (index) in
            print(index);
        }
        return banner;
    }()
    //MARK:- viewdidload
    override func viewDidLoad() {
        self.automaticallyAdjustsScrollViewInsets = false;
        self.title = "UOU";
        self.view.backgroundColor = kGrayColor;
        //创建naviBar
        let navBar = MainNaviBar(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 64));
        navBar.backgroundColor = kMainColor;
        navBar.addBlock = {
            print("点击了+");
        }
        self.view.addSubview(navBar);
        creatMainView();
        //创建tableView
        creatMainTB();
        
    }
    
    func creatMainView() {
        //首先隐藏掉tabbar
        self.navigationController?.navigationBar.isHidden = true;
        //
        
    }
    //创建主tableView
    func creatMainTB()  {
        _mainTB.delegate = self;
        _mainTB.dataSource = self;
        self.view.addSubview(_mainTB);
    }
    
    //进入定位界面
    
    func enterLocation()  {
        print("进入定位界面");                                                                                                                                                                                                                                                        
    }
    
    
    //使导航栏渐变
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self;
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController == self {
            self.navigationController?.navigationBar.tintColor = kMainColor;
            self.navigationController?.navigationBar.alpha = 0;
            self.navigationController?.navigationBar.isTranslucent = true;
        }else{
            self.navigationController?.navigationBar.tintColor = nil;
            self.navigationController?.navigationBar.alpha = 1;
            self.navigationController?.navigationBar.isTranslucent = false;
        }
        self.navigationController?.isNavigationBarHidden = true;
        
    }

    //MARK:- UITableViewDelete
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cellId";
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId);
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId);
            cell?.textLabel?.text = String(indexPath.row);
        }
        return cell!;
    }
}

typealias ClickAddBtnAction = ()->Void;
class MainNaviBar: UIView ,UISearchBarDelegate{
    var _frontView:UIView?
    var _backView:UIView?
    var addBlock:ClickAddBtnAction?
    
    override init(frame: CGRect) {
        //创建searchBar
        super.init(frame: frame)
        _frontView = UIView(frame:frame);
        self.addSubview(_frontView!)
        _backView = UIView(frame:frame);
        self.addSubview(_backView!)
        addFrontSubView()
        addBakcSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //添加frontView的subView
    func addFrontSubView(){
        let searchBar = UISearchBar(frame: CGRect(x: 10, y: 20, width: kScreenWidth - 40, height: 20));
        searchBar.tintColor = UIColor.blue;
        searchBar.text = "搜索"
        searchBar.image(for: .search, state: .normal)
        searchBar.delegate = self;
        _frontView?.addSubview(searchBar);
        
        let addBtn = UIButton(type: .custom);
        addBtn.frame = CGRect(x: kScreenWidth - 30, y: 20, width: 20, height: 20);
        addBtn.setImage(#imageLiteral(resourceName: "item"), for: .normal);
        addBtn.addTarget(self, action: "addBtnAction", for: .touchUpInside)
        _frontView?.addSubview(addBtn);
    }
    func addBtnAction() {
        addBlock!();
    }
    
    func addBakcSubView(){
        let searchBtn = UIButton(type: .custom);
        searchBtn.frame = CGRect(x: 20, y: 20, width: 20, height: 20);
        searchBtn.setImage(#imageLiteral(resourceName: "item"), for: .normal);
        searchBtn.addTarget(self, action: #selector(UISearchBarDelegate.searchBarShouldBeginEditing(_:)), for: .touchUpInside)
        _backView?.addSubview(searchBtn);
        
        let addBtn = UIButton(type: .custom);
        addBtn.frame = CGRect(x: kScreenWidth - 30, y: 20, width: 20, height: 20);
        addBtn.setImage(#imageLiteral(resourceName: "item"), for: .normal);
        addBtn.addTarget(self, action: "addBtnAction", for: .touchUpInside)
        _backView?.addSubview(addBtn);
        
        _backView?.alpha = 0;
    }
    
    func searchAction(){
        print("打开search")
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print("打开search")
        return true;
    }
    
    func exChangeAplahWhenScroll(scrollView:UIScrollView){
        let scrollOffsetY = scrollView.contentOffset.y;
        //讲scrollView划分成100的级别
        let frontAplah = 1.0 + scrollOffsetY/60.0;
        let backAplah = 0.0 - scrollOffsetY/60.0;
        _frontView?.alpha = frontAplah;
        _backView?.alpha = backAplah;
    }
}

