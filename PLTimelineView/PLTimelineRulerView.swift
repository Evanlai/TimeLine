//
//  PLTimelineRulerView.swift
//  PLTimelineView
//
//  Created by Patrick Lin on 11/10/2016.
//  Copyright © 2016 Patrick Lin. All rights reserved.
//

import UIKit

@IBDesignable class PLTimelineRulerView: UIView {
    
    var unit_hour_width: CGFloat = 60
    
    var unit_hour_height: CGFloat = 30
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
    }
    
    internal func drawEvent(_ rect: CGRect) {
        
        for i in 0..<10 {
            
//            let start = Date(timeIntervalSince1970: i == 0 ? 1672388400 : 1672389400)
//
//            let end = Date(timeIntervalSince1970: i == 0 ? 1672388920 : 1672399920)
            
            let start = Date(timeIntervalSince1970:TimeInterval(1672388400+(1000 * (i + i))))

            let end = Date(timeIntervalSince1970:TimeInterval(1672388920+(1000 * (i + i))))
            
            let unit_gap_height = CGFloat(20)
            
            let unit_minute_width = unit_hour_width / 6 / 10
            
            let unit_minute_height = CGFloat(unit_hour_height / 2)
            
            let unit_second_width = unit_minute_width / 10
            
            let unit_sec_height = CGFloat(unit_minute_height / 2)
            
            let wave_height = CGFloat(5)
            
            let start_hour = Calendar.current.component(.hour, from: start)
            
            let start_minute = Double(Calendar.current.component(.minute, from: start))
            
            let start_second = Double(Calendar.current.component(.second, from: start))
            
            let end_hour = Calendar.current.component(.hour, from: end)
            
            let end_minute = Double(Calendar.current.component(.minute, from: end))
            
            let end_second = Double(Calendar.current.component(.second, from: end))
            
            // 縮放時要加入這個值在 start_x , 因為 rect 會隨著縮放時的倍率增加，我們畫上的event才會跟著縮放.
            let unit_page = rect.width / 3
            
            let start_x = (unit_hour_width * CGFloat(start_hour)) + (unit_minute_width * CGFloat(start_minute)) + (unit_second_width * CGFloat(start_second / 6))

            let end_x = (unit_hour_width * CGFloat(end_hour)) + (unit_minute_width * CGFloat(end_minute)) + (unit_second_width * CGFloat(end_second / 6))
            
            UIColor.blue.setFill()
            
            UIRectFill(CGRect(x: start_x + unit_page, y: rect.size.height - wave_height - unit_gap_height, width: end_x - start_x, height: wave_height))
            
            
        }
        
        
        self.setNeedsDisplay()
        
    }
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        UIColor.clear.setFill()
        
        UIRectFill(rect)
        
        UIColor.lightGray.setFill()
        
        let unit_gap_height = CGFloat(20)
        
        let unit_minute_width = unit_hour_width / 6
        
        let unit_minute_height = CGFloat(unit_hour_height / 2)
        
        let unit_second_width = unit_minute_width / 10
        
        let unit_sec_height = CGFloat(unit_minute_height / 2)
        
        let show_hour = unit_hour_width > 10 ? true : false

        let show_minute = unit_minute_width > 10 ? true : false

        let show_second = unit_second_width > 5 ? true : false
        
        let unit_page = rect.width / 3
        
        let textFontAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 8),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.paragraphStyle: NSParagraphStyle.default
        ]
        
        let text_width = CGFloat(34)
        
        let text_height = CGFloat(12)
        
        for i in 0...2 {
            
            for hour in 0...23 {
                
                let hour_x = CGFloat(hour) * unit_hour_width + (CGFloat(i) * unit_page)
                
                let hour_y = rect.size.height - unit_hour_height
                
                UIRectFill(CGRect(x: hour_x, y: hour_y - unit_gap_height, width: 1, height: unit_hour_height))
                // default for minute in 1..<6
                for minute in 0..<6 {
                    
                    let minute_x = CGFloat(minute) * unit_minute_width
                    
                    let minute_y =  rect.size.height - unit_minute_height
                    
                    UIRectFill(CGRect(x: hour_x + minute_x, y: minute_y - unit_gap_height, width: 1, height: unit_minute_height))
                    
                    if show_second == true {
                        
                        for second in 0..<10 {
                            
                            let second_x = CGFloat(second) * unit_second_width

                            let second_y = rect.size.height - unit_sec_height

                            //UIColor.red.setFill()

                            UIRectFill(CGRect(x: hour_x + minute_x + second_x, y: second_y - unit_gap_height, width: 1, height: unit_sec_height))

                        }
                        
                        
                    }
                    
                    
                    if unit_minute_width > text_width {
                        // let text_x = hour_x + minute_x - (text_width / 2)
                        let text_x = hour_x + minute_x - (text_width / 3)
                        
                        let text_y = rect.size.height - 17
                        
                        (String(format: "%02d:%02d", hour, minute*10) as NSString).draw(in: CGRect(x: text_x, y: text_y, width: text_width, height: text_height), withAttributes: textFontAttributes)
                        
                    }
                    
                    
                }
                // default let text_x = hour_x - (text_width / 2)
                let text_x = hour_x - (text_width / 3)
                
                let text_y = rect.size.height - 17
                
                (String(format: "%02d:00", hour) as NSString).draw(in: CGRect(x: text_x, y: text_y, width: text_width, height: text_height), withAttributes: textFontAttributes)
                
            }
            
        }
        
        UIRectFill(CGRect(x: 0, y: 0, width: rect.size.width, height: 0.5))
        
        UIRectFill(CGRect(x: 0, y: rect.size.height - 20, width: rect.size.width, height: 0.5))
        
        self.drawEvent(rect)
        
    }
    
    // MARK: Init Methods
    
    func commonInit() {
        
        self.isOpaque = false
        
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.commonInit()
        
    }

}
