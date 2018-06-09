//
//  SwipeView.swift
//  FilmSwipe
//
//  Created by Dylan Southard on 2018/06/07.
//  Copyright © 2018 Dylan Southard. All rights reserved.
//

import UIKit

class SwipeView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var posterImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("SwipeView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
