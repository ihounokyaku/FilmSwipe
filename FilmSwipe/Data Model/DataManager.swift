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
    
    //MARK: - ==Create New==
    func newMovie(withID id:String, title:String, imageUrl:String, genres:[String], desc:String, rtScore:Int, imdbScore:Double) {
        let movie = Movie()
        movie.imageUrl = imageUrl
        movie.title = title
        movie.genres = genres.asList()
        movie.desc = desc
        movie.rtScore = rtScore
        movie.imdbScore = imdbScore
        movie.id = id
        //TODO: - MAKE THUMBNAIL
        self.save(object: movie)
    }
    
    //MARK: - ==Save==
    func save(object:Object) {
        do {
            try self.realm.write {
                realm.add(object)
            }
        } catch {
            print("Error saving object \(error)")
        }
    }
    
}
