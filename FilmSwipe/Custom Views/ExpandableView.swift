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
        
        guard let vc = self.delegate else {return}

        //MARK: Get new height
        let newHeight = contentView.frame.height == self.originalHeight ? vc.view.frame.height - 200 : self.originalHeight
        let heightDifference = newHeight - vc.expandView.frame.height
        let buttonLabel = contentView.frame.height == self.originalHeight ? "Down" : "Up"
        
        //MARK: Resize View
        UIView.animate(withDuration: 0.5, animations: {
            vc.expandView.frame = CGRect(x: vc.expandView.frame.origin.x, y: vc.expandView.frame.origin.y - heightDifference, width: vc.expandView.frame.width, height:newHeight)
        }) { _ in
            self.upDownButton.setTitle(buttonLabel, for: .normal)
        }
        
        //MARK: enable/disable swipe
        vc.kolodaView.isUserInteractionEnabled = vc.expandView.frame.height == self.originalHeight
        
    }

    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
