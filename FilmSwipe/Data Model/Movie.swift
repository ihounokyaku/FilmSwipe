//
//  Movie.swift
//  FilmSwipe
//
//  Created by Dylan Southard on 2018/06/10.
//  Copyright © 2018 Dylan Southard. All rights reserved.
//

import Foundation
import RealmSwift

class Movie : Object {
    @objc dynamic var id = ""
    @objc dynamic var title = "No Title"
    @objc dynamic var thumbnailName = "noImage.png"
    @objc dynamic var imageUrl = ""
    @objc dynamic var desc = ""
    @objc dynamic var rtScore = 0
    @objc dynamic var imdbScore:Double = 0
    @objc dynamic var trailerUrl:String = ""
    
    var genres = List<String>()
    //MARK: - allow access to the thumbnail image from the database
    var thumbnail : UIImage {
        get {
            return self.thumbnailName.image()
        }
        set {
            guard let resized = newValue.resized(toWidth: 100) else {return}
            self.thumbnailName = self.title + "\(Date().timeIntervalSince1970)"
            resized.saveAsPng(named: self.thumbnailName)
        }
    }

}
