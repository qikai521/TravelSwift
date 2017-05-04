//
//  File.swift
//  TravelSwift
//
//  Created by iMac on 17/5/3.
//  Copyright © 2017年 iMac. All rights reserved.
//

import RAMAnimatedTabBarController

class RootViewController: RAMAnimatedTabBarController,UIViewControllerTransitioningDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad();
        view.backgroundColor = UIColor.white;
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    override func tapHandler(_ gesture: UIGestureRecognizer) {
        if gesture.view?.tag == 2{
            let searchVC = SearchVC();
            searchVC.transitioningDelegate = self;
            self.present(searchVC, animated: true, completion: {
                
            })
            return;
        }else{
            super.tapHandler(gesture);
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation();
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation();
    }
}

