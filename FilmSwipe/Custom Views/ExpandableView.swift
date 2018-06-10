//
//  SwipeView.swift
//  FilmSwipe
//
//  Created by Dylan Southard on 2018/06/07.
//  Copyright © 2018 Dylan Southard. All rights reserved.
//

import UIKit

class ExpandableView: UIView {
    //MARK: - ===================IBOUTLETS========================
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var upDownButton: UIButton!
    
    //MARK: - ===================VARIABLES========================
    //MARK: - ==Delegates==
    var delegate:ViewController?
    
    //MARK: - ==OtherVariables==
    var originalHeight:CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.commonInit()
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ExpandableView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
         self.originalHeight = self.contentView.frame.height
        
    }

    
    @IBAction func upPressed(_ sender: Any) {
        //MARK: Get new height
        let vcHeight = self.delegate != nil ? self.delegate!.view.frame.height : self.originalHeight + 100
        let newHeight = contentView.frame.height == self.originalHeight ? vcHeight - 200 : self.originalHeight
        print("original height \(self.originalHeight) new height = \(newHeight)")
        let heightDifference = newHeight - self.contentView.frame.height
        
        UIView.animate(withDuration: 0.5, animations: {
            self.contentView.frame = CGRect(x: self.contentView.frame.origin.x, y: self.contentView.frame.origin.y - heightDifference, width: self.contentView.frame.width, height:newHeight)
        }) { _ in
            self.upDownButton.setTitle("Down", for: .normal)
        }
    }
    
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
