//
//  SoundsFactory.swift
//  MusicMemoryGame
//
//  Created by joseewu on 2018/3/20.
//  Copyright © 2018年 com.nietzsche. All rights reserved.
//

import UIKit
import AudioKit

class SoundsFactory: NSObject {
    let waveform = AKTable(.sine, phase:20, count: 4_096)
    let oscillator:AKOscillator
    static let shared: SoundsFactory = {
        let instance = SoundsFactory()
        return instance
    }()
    override init() {
        oscillator = AKOscillator(waveform: waveform)
        super.init()
        AudioKit.output = oscillator
        AudioKit.start()
    }
    func playSound(withHz frequency:Int) {
        oscillator.frequency = Double(frequency)
        oscillator.rampTime = 0.001
        oscillator.amplitude = 1
        oscillator.play()

    }
    func stopSound() {
        oscillator.amplitude = 0

    }
}
