//
//  SwiftTimer.swift
//  TravelSwift
//
//  Created by iMac on 17/5/8.
//  Copyright © 2017年 iMac. All rights reserved.
//

import UIKit

class SwiftTimer: NSObject {
    let internalTimer:DispatchSourceTimer;
    private var isRunning = false;
    init(interval:DispatchTimeInterval,isRepear:Bool = false,queue:DispatchQueue = DispatchQueue.main) {
        internalTimer = DispatchSource.makeTimerSource(flags: [], queue: queue);
        if isRepear {
            internalTimer.scheduleRepeating(deadline: DispatchTime.now(), interval: interval)
        }else{
            internalTimer.scheduleOneshot(deadline: DispatchTime.now() + interval);
        }
    }
    
    deinit {
        internalTimer.cancel();
    }
    
    func start() {
        internalTimer.resume();
        isRunning = true;
    }
    
    func stop()  {
        if isRunning {
            internalTimer.suspend();
            isRunning = false;
        }
    }
    
    
}
