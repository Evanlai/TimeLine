//
//  PLTimelineContentView.swift
//  PLTimelineView
//
//  Created by Patrick Lin on 11/10/2016.
//  Copyright © 2016 Patrick Lin. All rights reserved.
//

import UIKit

@IBDesignable class PLTimelineContentView: UIScrollView {

    var rulerView: PLTimelineRulerView!
    
    var rulerDefalutSize: CGFloat = 60;
    
    func updateRuler() {
        
        self.layoutIfNeeded()
        
        self.contentSize = CGSize(width: self.rulerView.unit_hour_width * 24 * 3, height: self.bounds.size.height)
        
        self.rulerView.frame = CGRect(x: 0, y: 0, width: self.contentSize.width, height: self.contentSize.height)
        
    }
    
    func changeUpdateRuler(size:CGFloat,currDate:Date) {
        
        let hour = Calendar.current.component(.hour, from: currDate)
        
        let minute = Calendar.current.component(.minute, from: currDate)
        
        let second = Calendar.current.component(.second, from: currDate)
            
        if self.rulerView.unit_hour_width * size < 30 || self.rulerView.unit_hour_width * size > 1920 {
            
            self.rulerView.unit_hour_width = self.rulerView.unit_hour_width * size > 1920 ? 1920 : self.rulerView.unit_hour_width * size

            self.rulerView.unit_hour_width = self.rulerView.unit_hour_width * size < 30 ? 30 : self.rulerView.unit_hour_width * size

        }
        else{
            
            self.rulerView.unit_hour_width = self.rulerView.unit_hour_width * size
            
        }
            
        self.contentSize = CGSize(width: (self.rulerView.unit_hour_width) * 24 * 3, height: self.bounds.size.height)
        
        self.rulerView.frame = CGRect(x: 0, y: 0, width: self.contentSize.width, height: self.contentSize.height)

        self.rulerView.setNeedsDisplay()
     
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.updateRuler()
        
    }
    
    // MARK: Init Methods
    
    func commonInit() {
        
        self.showsVerticalScrollIndicator = false
        
        self.showsHorizontalScrollIndicator = false
        
        self.isOpaque = false
        
        self.rulerView = PLTimelineRulerView()
        
        self.addSubview(self.rulerView)
        
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
