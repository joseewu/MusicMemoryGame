//
//  CountingView.swift
//  MusicMemoryGame
//
//  Created by joseewu on 2018/4/1.
//  Copyright © 2018年 com.nietzsche. All rights reserved.
//

import UIKit

class CountingView: UIView {
    private let hour:UILabel = UILabel()
    private let minute:UILabel = UILabel()
    private let seconds:UILabel = UILabel()
    private let separate1:UILabel = UILabel()
    private let separate2:UILabel = UILabel()
    private var mainFont:UIFont {
        return UIFont(name: "Thonburi-Bold", size: 30)!
    }
    private var labelWidth:CGFloat {
        return (frame.width - 60)/3
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        renderUi()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func renderUi() {
        hour.text = "00"
        hour.textAlignment = .center
        hour.textColor = UIColor.white
        hour.font = mainFont
        addSubview(hour)
        separate1.text = ":"
        separate1.textAlignment = .center
        separate1.textColor = UIColor.white
        separate1.font = mainFont
        addSubview(separate1)
        minute.text = "00"
        minute.textAlignment = .center
        minute.textColor = UIColor.white
        minute.font = mainFont
        addSubview(minute)
        separate2.text = ":"
        separate2.textAlignment = .center
        separate2.textColor = UIColor.white
        separate2.font = mainFont
        addSubview(separate2)
        seconds.text = "00"
        seconds.textAlignment = .center
        seconds.textColor = UIColor.white
        seconds.font = mainFont
        addSubview(seconds)
        setConstraints()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    private func setConstraints() {
        hour.frame = CGRect(x: 0, y: 0, width: labelWidth, height: frame.size.height)
        separate1.frame = CGRect(x: labelWidth, y: 0, width: 30, height: frame.size.height)
        minute.frame = CGRect(x: labelWidth+30, y: 0, width: labelWidth, height: frame.size.height)
        separate2.frame = CGRect(x: labelWidth*2+30, y: 0, width: 30, height: frame.size.height)
        seconds.frame = CGRect(x: labelWidth*2+60, y: 0, width: labelWidth, height: frame.size.height)
    }
    public func update(hours:String, minutes:String, seconds:String) {
        hour.text = hours
        minute.text = minutes
        self.seconds.text = seconds
    }
}
