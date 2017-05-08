//
//  MainBanner.swift
//  TravelSwift
//
//  Created by iMac on 17/5/4.
//  Copyright © 2017年 iMac. All rights reserved.
//

import UIKit
import SDWebImage


class  MainBannerView: UIView {
    var bannerScroll:BannerScrollView?
    var pageView:UIPageControl?
    override init(frame:CGRect){
        super.init(frame: frame);
        creatSubViews();
    }
    
    func creatSubViews() {
        bannerScroll = BannerScrollView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height));
        bannerScroll?.backgroundColor = UIColor.black;
        self.addSubview(bannerScroll!);
        
        pageView = UIPageControl(frame:CGRect())
        pageView?.numberOfPages = 3;
        pageView?.currentPage = 0;
        pageView?.pageIndicatorTintColor = UIColor.white;
        pageView?.currentPageIndicatorTintColor = kMainColor;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


typealias ClickBannerImgIndexClosure = (Int)->Void;
class BannerScrollView: UIScrollView ,UIScrollViewDelegate{
    
    var imgCount:Int?
    var clickCloseure:ClickBannerImgIndexClosure?
    var imageURLArr = Array<URL>();
    var notNeedAnimation:Bool = false;
    var crtShowIndex:Int = 0{
        didSet{
            if crtShowIndex > oldValue {
                //说明是向右滑动的
                crtShowIndex = getRealIndex(value: crtShowIndex)
                if !notNeedAnimation {
                    UIView.animate(withDuration: 1, animations: {
                        self.setContentOffset(CGPoint(x: self.bounds.size.width * 3, y: 0), animated: true);
                    })
                }else{
                    self.resetURLAndScrollOffset(index: self.crtShowIndex);
                }
                print("crtShowIndex = ",crtShowIndex)
            }else{
                //想左滑动
                crtShowIndex = getRealIndex(value: crtShowIndex)
                self.resetURLAndScrollOffset(index: self.crtShowIndex);
                 print("crtShowIndex = ",crtShowIndex)
            }
        }
    }
    
    var bestLeftImgV:UIImageView?;
    var leftImgV:UIImageView?;
    var centerImgV:UIImageView?;
    var rightImgV:UIImageView?;
    var bestRightImgV:UIImageView?;
    var timer:SwiftTimer?;
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        delegate = self;
        creatSubViews();
        self.isPagingEnabled = true;
        self.showsVerticalScrollIndicator = false;
        self.showsHorizontalScrollIndicator = false;
        //尽量保持中间的当前显示的图片位置中央位置
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //创建subViews
    func creatSubViews() {
        
        bestLeftImgV = creatOneSubView(left: 0);
        bestLeftImgV?.backgroundColor = UIColor.red;
        
        leftImgV = creatOneSubView(left: self.frame.size.width);
        leftImgV?.backgroundColor = UIColor.orange;
        
        centerImgV = creatOneSubView(left: self.frame.size.width * 2.0);
        centerImgV?.backgroundColor = UIColor.yellow;
        
        rightImgV = creatOneSubView(left: self.frame.size.width * 3.0);
        rightImgV?.backgroundColor = UIColor.green;
        
        bestRightImgV = creatOneSubView(left: self.frame.size.width * 4.0);
        bestRightImgV?.backgroundColor = UIColor.blue;
        
        
    }
    
    func creatOneSubView(left:CGFloat) ->(UIImageView){
        let imgV = UIImageView(frame: CGRect(x: left, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        self.addSubview(imgV);
        return imgV;
    }
    
    //一般用于请求图片url结束之后来设置的
    func setBannerImgWithUrls(urls:Array<String>,backClickFunc:@escaping (_:Int) ->Void) {
        clickCloseure = backClickFunc;
        self.contentSize = CGSize(width: self.bounds.size.width * CGFloat(5), height: 0);
        for index in 0...urls.count-1 {
            let url = URL(string: urls[index]);
            imageURLArr.append(url!);
        }
        resetURLAndScrollOffset(index: 0);
        beginTimer();
    }
    //重新设置URL 并且让当前看到的位置位于center
    func resetURLAndScrollOffset(index:Int)  {
        let bestLeftIndex = getRealIndex(value: index - 2);
        let leftIndex = getRealIndex(value: index - 1);
        let centerIndex = getRealIndex(value: index);
        let rightIndex = getRealIndex(value: index + 1);
        let bestRightIndex = getRealIndex(value: index + 2);
        
        bestLeftImgV?.sd_setImage(with: imageURLArr[bestLeftIndex], placeholderImage: #imageLiteral(resourceName: "placeHolder"));
        leftImgV?.sd_setImage(with: imageURLArr[leftIndex], placeholderImage: #imageLiteral(resourceName: "placeHolder"));
        centerImgV?.sd_setImage(with: imageURLArr[centerIndex], placeholderImage: #imageLiteral(resourceName: "placeHolder"));
        rightImgV?.sd_setImage(with: imageURLArr[rightIndex], placeholderImage: #imageLiteral(resourceName: "placeHolder"));
        bestRightImgV?.sd_setImage(with: imageURLArr[bestRightIndex], placeholderImage: #imageLiteral(resourceName: "placeHolder"));

        self.setContentOffset(CGPoint(x: self.bounds.size.width * 2 , y : 0), animated: false);
    }
    
    //通过index 得到真正的index
    func getRealIndex(value:Int) -> Int {
        var backIndex = value;
        while backIndex >= imageURLArr.count {
            backIndex = backIndex - imageURLArr.count;
        }
        while backIndex < 0  {
            backIndex = backIndex + imageURLArr.count;
        }
        return backIndex;
    }
    func beginTimer() {
        timer = SwiftTimer(interval: DispatchTimeInterval.seconds(8), isRepear: true, queue: DispatchQueue.global())
        timer!.internalTimer.setEventHandler {
            self.crtShowIndex += 1;
        }
        timer!.start();
    }
    
    deinit {
        timer?.stop();
        timer = nil;
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            endScroll();
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        endScroll();
    }
    
    func endScroll() {
        notNeedAnimation = true;
        if self.contentOffset.x > self.frame.size.width * 2.5 {
            crtShowIndex += 1;
        }else if self.contentOffset.x < self.frame.size.width * 1.5{
            crtShowIndex -= 1;
        }else{
            
        }
        notNeedAnimation = false;
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
    
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("stop")
        self.resetURLAndScrollOffset(index: self.crtShowIndex);
    }
    
    
    
}
