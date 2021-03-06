//
//  Global Variables.swift
//  FilmSwipe
//
//  Created by Dylan Southard on 2018/06/12.
//  Copyright © 2018 Dylan Southard. All rights reserved.
//

import Foundation

var DocumentsDirectory: URL {
    get {
       return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

//MARK: - =========GENRES=========
let GenreIDs = ["Action":"28",
                "Adventure":"12",
                "Animation":"16",
                "Comedy":"35",
                "Crime":"80",
                "Documentary":"99",
                "Drama":"18",
                "Family":"10751",
                "Fantasy":"14",
                "History":"36",
                "Horror":"27",
                "Music":"10402",
                "Mystery":"9648",
                "Romance":"10749",
                "Science Fiction":"878",
                "TV Movie":"10770",
                "Thriller":"53",
                "War":"10752",
                "Western":"37"]

let Genres = ["Action",
              "Adventure",
              "Animation",
              "Comedy",
              "Crime",
              "Documentary",
              "Drama",
              "Family",
              "Fantasy",
              "History",
              "Horror",
              "Music",
              "Mystery",
              "Romance",
              "Science Fiction",
              "TV Movie",
              "Thriller",
              "War",
              "Western"]
