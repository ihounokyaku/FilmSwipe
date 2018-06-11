//
//  NavContainer.swift
//  FilmSwipe
//
//  Created by Dylan Southard on 2018/06/11.
//  Copyright © 2018 Dylan Southard. All rights reserved.
//

import UIKit

class NavContainer: UIViewController {
//MARK: - ===========IBOUTLETS============
    //MARK: - ==VIEWS==
    @IBOutlet weak var subviewContainer: UIView!
    
    //MARK: - ==BUTTONS==
    @IBOutlet weak var swipeButton: UIButton!
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    
    //MARK: - =========== VARIABLES============
    var dataManager = DataManager()
    var currentSubview:NavSubview!
    
     //MARK: - =========== SETUP ============
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Load first VC
        self.addAndPosition(viewController: self.getSubview("Swiper"), xValue: 0)
    }
    
    //MARK: - =========BUTTON ACTIONS===========
    //MARK: - ==NavigationButtons==
    @IBAction func swipePressed(_ sender: Any) {
        self.fadeTransition(toVCWithIdentifier: "Swiper")
    }
    
    @IBAction func favoritesPressed(_ sender: Any) {
        self.fadeTransition(toVCWithIdentifier: "Favorites")
    }
    
    @IBAction func settingsPressed(_ sender: Any) {
    }
    
    
    //MARK: - =========PRESENT VC===========

    //MARK: - ==ANIMATE TRANSITION==
    func fadeTransition(toVCWithIdentifier identifier: String) {
        //MARK: Get destination
        let destinationVC = self.getSubview(identifier)
        
        //MARK: Set alpha and position
        destinationVC.view.alpha = 0
        self.addAndPosition(viewController:destinationVC, xValue: 0)
        
        //MARK: Animate Transition
        UIView.animate(withDuration:0.3, animations:{
            destinationVC.view.alpha = 1
            self.subviewContainer.subviews[0].alpha = 0
        }, completion: {(finished: Bool) in
           self.removeSubviews()
        })
    }
    
    //MARK: - ==GET VC==
    func getSubview (_ identifier:String)-> NavSubview {
        
        //-- Create VC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: identifier) as! NavSubview
        
        //-- Assign container
        newVC.container = self
        return newVC
    }
    
    //MARK: - ==CALL THAT VC UP==
    func addAndPosition(viewController:NavSubview, xValue:CGFloat) {
        self.addChildViewController(viewController)
        self.subviewContainer.addSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
        viewController.view.frame = CGRect(x: xValue, y: 0, width: self.subviewContainer.frame.size.width, height:self.subviewContainer.frame.size.height)
       self.currentSubview = viewController
        self.toggleButtons()
    }
    
    //MARK: - ==REMOVE SUBVIEWS==
    func removeSubviews () {
            while self.subviewContainer.subviews.count > 1 {
                self.subviewContainer.subviews[0].removeFromSuperview()
            }
    }
    
    //MARK: - =========UI UPDATE===========
    func toggleButtons() {
        self.swipeButton.isEnabled = self.currentSubview as? ViewController == nil
        self.favoritesButton.isEnabled = self.currentSubview as? LikedMoviesVC == nil
    }


}
