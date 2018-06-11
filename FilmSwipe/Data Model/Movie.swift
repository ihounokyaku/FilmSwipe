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
    @objc dynamic var thumbnail = "NoImage.png"
    @objc dynamic var imageUrl = ""
    //TODO: Create no image png
    @objc dynamic var desc = ""
    var genres = List<String>()
    @objc dynamic var rtScore = 0
    @objc dynamic var imdbScore:Double = 0
}
