//
//  ViewController.swift
//  FilmSwipe
//
//  Created by Dylan Southard on 2018/06/07.
//  Copyright © 2018 Dylan Southard. All rights reserved.
//

import UIKit
import Koloda
import pop

class ViewController: UIViewController {
    //MARK: - ==========IBOUTLETS===========
    @IBOutlet weak var kolodaView: KolodaView!
    @IBOutlet weak var expandView: ExpandableView!
    
    //MARK: - ==========VARIABLES===========
    var images = [#imageLiteral(resourceName: "cat"),#imageLiteral(resourceName: "cat2"),#imageLiteral(resourceName: "cat3"),#imageLiteral(resourceName: "cat4"),#imageLiteral(resourceName: "cat5")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.kolodaView.delegate = self
        self.kolodaView.dataSource = self
        self.expandView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : KolodaViewDelegate, KolodaViewDataSource {
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        //return UIImageView(image: self.images[index])
        return SwipeView(frame: self.view.frame)
        
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return 1000
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        switch direction {
        case .right:
            print("right")
        case .left:
            print("left")
        case .bottomLeft:
            print("bottom left")
        case  .bottomRight:
            print("bottom right")
        case .topLeft:
            print("top left")
        case .topRight:
            print("top right")
        case .up:
            print("up")
        case .down:
            print("down")
        }
        self.images.append(self.images[index])
    }
    
}



