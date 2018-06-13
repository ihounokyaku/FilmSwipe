//
//  DataManager.swift
//  FilmSwipe
//
//  Created by Dylan Southard on 2018/06/11.
//  Copyright © 2018 Dylan Southard. All rights reserved.
//

import Foundation
import RealmSwift

class DataManager:NSObject {
//MARK - =================== Arrays =================
    var likedMovies:Results<Movie>!
    
//MARK - =================== Other vars =================
    let realm = try! Realm()
    
    override init () {
        super.init()
        self.likedMovies = self.realm.objects(Movie.self)
    }
    
    //MARK: - ========== CREATE ==========
    
    //MARK: - ==Save==
    func saveToFavorites(movie:Movie, thumbnail:UIImage) {
        movie.thumbnail = thumbnail
        do {
            try self.realm.write {
                realm.add(movie)
            }
        } catch {
            print("Error saving object \(error)")
        }
    }
    
}
