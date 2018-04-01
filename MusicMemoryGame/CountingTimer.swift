//
//  CountingTimer.swift
//  MusicMemoryGame
//
//  Created by joseewu on 2018/4/1.
//  Copyright © 2018年 com.nietzsche. All rights reserved.
//

import UIKit

class CountingTimer: NSObject {
    private var timer:Timer = Timer()
    var isTimerRunning = false
    static let shared: CountingTimer = {
        let instance = CountingTimer()
        return instance
    }()
    override init() {
        super.init()
        timer.invalidate()
    }
}
