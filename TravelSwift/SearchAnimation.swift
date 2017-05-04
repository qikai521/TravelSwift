//
//  SearchAnimation.swift
//  TravelSwift
//
//  Created by iMac on 17/5/3.
//  Copyright © 2017年 iMac. All rights reserved.
//

import UIKit


class PresentAnimation: NSObject,UIViewControllerAnimatedTransitioning,CAAnimationDelegate {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7;
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!;
        let containerView = transitionContext.containerView;
        containerView.addSubview(toVC.view);
        
        let radius = sqrt(pow(containerView.frame.size.width, 2) + pow(containerView.frame.size.height, 2))/2.0;
        
        let endCycle = UIBezierPath(arcCenter: containerView.center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2.0), clockwise: true);
        let startCycle = UIBezierPath(rect: CGRect(x: containerView.center.x, y: containerView.center.y, width: 0, height: 0));
        
        //创建CAShapeLayer进行遮盖
        let maskLayer = CAShapeLayer();
        maskLayer.path = endCycle.cgPath;
        toVC.view.layer.mask = maskLayer;
        
        //创建路径动画
        let animation = CABasicAnimation(keyPath: "path");
        animation.delegate = self;
        animation.fromValue = startCycle.cgPath;
        animation.toValue = endCycle.cgPath;
        animation.duration = transitionDuration(using: transitionContext);
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);
        animation.setValue(transitionContext, forKey: "transitionContext");
        maskLayer.add(animation, forKey: "path");
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let transitionContext:UIViewControllerContextTransitioning = anim.value(forKey: "transitionContext") as! UIViewControllerContextTransitioning;
        transitionContext.completeTransition(true);
        let toVC:UIViewController = transitionContext.viewController(forKey: .to)!;
        toVC.view.layer.mask = nil;
        
        let vc:UIViewController = transitionContext.viewController(forKey: .to)!;
        vc.view.layer.mask = nil;
    }
}

class DismissAnimation: NSObject,UIViewControllerAnimatedTransitioning,CAAnimationDelegate {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7;
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!;
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!;
        let containerView = transitionContext.containerView;
        containerView.insertSubview(toVC.view, at: 0);
        let radius = sqrt(pow(containerView.frame.size.width, 2) + pow(containerView.frame.size.height, 2))/2.0;
        
        let startCycle = UIBezierPath(arcCenter: containerView.center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2.0), clockwise: true);
        let endCycle = UIBezierPath(rect: CGRect(x: containerView.center.x, y: containerView.center.y, width: 0, height: 0));
        
        //创建CAShapeLayer进行遮盖
        let maskLayer = CAShapeLayer();
        maskLayer.fillColor = kMainColor.cgColor;
        maskLayer.path = endCycle.cgPath;
        fromVC.view.layer.mask = maskLayer;
        
        //创建路径动画
        let animation = CABasicAnimation(keyPath: "path");
        animation.delegate = self;
        animation.fromValue = startCycle.cgPath;
        animation.toValue = endCycle.cgPath;
        animation.duration = transitionDuration(using: transitionContext);
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);
        animation.setValue(transitionContext, forKey: "transitionContext");
        maskLayer.add(animation, forKey: "path");
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let transitionContext:UIViewControllerContextTransitioning = anim.value(forKey: "transitionContext") as! UIViewControllerContextTransitioning;
        transitionContext.completeTransition(true);
        let vc:UIViewController = transitionContext.viewController(forKey: .from)!;
        vc.view.layer.mask = nil;
    }
}
