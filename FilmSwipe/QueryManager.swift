//
//  QueryManager.swift
//  FilmSwipe
//
//  Created by Dylan Southard on 2018/06/12.
//  Copyright © 2018 Dylan Southard. All rights reserved.
//

import UIKit

class QueryManager: NSObject {
    
    //MARK: - ==========VARIABLES==========
    var urlString = "https://api.themoviedb.org/3/discover/movie?api_key=7f8097fbd3d28753af1c79372d180dd4"
    
    //MARK: - ==COUNTS/ARRAYS==
    var idArray = [Int]()
    var pageCount = 1
    var movieCount = Int()
    var movieLoadCount = Int()
    var movieDisplayArray = [Movie]()
    
    //MARK: - ==DELEGATE==
    var delegate:ViewController!
    
    //MARK: - ==========MAKE THAT QUERY==========
    func querySetup(){
        
        //MARK: preset test Query
        //-------------Get rid of these after creating settings view--------------------//
        
        //******CHECK ---- I changed "Vars" to "Prefs" because I am an retard who needs everything spelled out for me
        Prefs.genre = "Comedy"
        Prefs.country = "US"
        Prefs.releaseYear = "1985"
        Prefs.sortType = "Popularity"
        //--------------fuck-----cunt-----taco-------tits-------------------------------/
        
        //MARK: filter by genre
        
        //******CHECK ---- I went ahead and made a genre dictionary in the Global Variables file and made this just refer to that 'cause I'm a fucking champ
        
        if Prefs.genre !=  "" {
            let genreID = GenreIDs[Prefs.genre] != nil ? GenreIDs[Prefs.genre]! : "35"
            self.urlString += "&genre/\(genreID)/movies?"
        }
        
        //MARK: filter by country
        //-------------need more countries---Merika #1 Trump rulz--------------//

        if Prefs.country != "" {
            
            //******CHECK ---- I assume it is the same string for each country, so I got rid of the switch and
            self.urlString = self.urlString + "&certification_country=" + Prefs.country + "&"
        }
        
        //MARK: release year like a mutha fucka
        if Prefs.releaseYear != "" {
            self.urlString = self.urlString + "&primary_release_year=\(Prefs.releaseYear)&"
        }
        
        //MARK: sorting shit and twats
        if Prefs.sortType != "" {
            
            //******CHECK ---- Same thing as above to lazy to tye it again. I guess this is about the same lenghth anyways though. DAMMIT! I suck at being lazy
            self.urlString = self.urlString + "&sort_by=" + Prefs.sortType + ".desc"
        }
        
        getMovieIDs()
        
    }
    
    
    //MARK: - get 20 movie IDs
    func getMovieIDs(){
        
        self.urlString = self.urlString + "&page=\(self.pageCount)"
        
        
        URLSession.shared.dataTask(with: URL(string: self.urlString)!) { (data, response, error) in
            if  data != nil {
                let responseString = String(data: data!, encoding: .utf8)!
                if(responseString != ""){
                    let responseValues = responseString.toDictionary()
                    
                    //MARK: QUERY THAT SHIT!
                    DispatchQueue.main.async {
                        
                        self.idArray.append(contentsOf: Array(responseValues.mutableArrayValue(forKeyPath: "results.id")) as! [Int])
                        print(self.idArray.count)

                        self.getMovieInfo()
                        
                    }
                }
            }
            }.resume()
    }
    
    
    
    func getMovieInfo(){
        
        
        DispatchQueue.main.async {
            for i in self.movieLoadCount ..< self.idArray.count {
                
                //MARK: MovieVariables
                
                //******CHECK ---- I made these local variables so we can use them to create a movie object and keep everything in one array.
                
                var trailerURLString = String()
                var description = "Apparently this movie defies description."
                var posterUrlPath = ""
                var title = "No Title"
                var genres = [String]()
                let id = self.idArray[i]
                
                URLSession.shared.dataTask(with: URL(string: "http://api.themoviedb.org/3/movie/\(self.idArray[self.movieLoadCount])/videos?api_key=7f8097fbd3d28753af1c79372d180dd4")!) { (data, response, error) in
                    if  data != nil {
                        let responseString = String(data: data!, encoding: .utf8)!
                        if(responseString != ""){
                            let responseValues = responseString.toDictionary()
                            
                            DispatchQueue.main.async {
                                
                                trailerURLString = String(describing: responseValues.value(forKeyPath: "results.key")!).replacingOccurrences(of: "[\"\'\\[\\]^+<>()]", with: "", options: .regularExpression, range: nil).trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: ",").first!
                                let tempTrailerIdArray =  trailerURLString.components(separatedBy: ",")
                                trailerURLString = "https://www.youtube.com/embed/\(tempTrailerIdArray[0])"
                            }
                        }
                    }
                    }.resume()
                
                URLSession.shared.dataTask(with:URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=7f8097fbd3d28753af1c79372d180dd4&append_to_response=credits")!) { (data, response, error) in
                    if  data != nil {
                        let responseString = String(data: data!, encoding: .utf8)!
                        if(responseString != ""){
                            let responseValues = responseString.toDictionary()
                            
                            print(responseValues)
                            DispatchQueue.main.async {
                                
                                //MARK: get Description
                                if let desc = responseValues.value(forKeyPath: "overview") as? String {
                                    description = desc
                                }
                                
                                //MARK: get poster path
                                if let posterPath = responseValues.value(forKeyPath: "poster_path") as? String {
                                    posterUrlPath = posterPath
                                }
                                
                                //MARK: get poster path
                                if let movieTitle = responseValues.value(forKeyPath: "title") as? String {
                                    title = movieTitle
                                }
                                
                                //MARK: get genres
                                if let movieGenres = responseValues.value(forKeyPath: "genres") as? [NSDictionary] {
                                    for genre in movieGenres {
                                        if let genreName = genre["name"] as? String {
                                            genres.append(genreName)
                                        }
                                    }
                                }
                                
                                
                                //TODO: get rotten tomatoes score, imdb score - we may need to switch to the OMDB
                                

                                //MARK: Make Movie file and add to display array
                                let movie = self.newMovie(withID: id, title: title, imageUrl: posterUrlPath, genres: genres, desc: description, rtScore: 50, imdbScore: 8.5, trailerUrl: trailerURLString)
                                self.movieDisplayArray.append(movie)
                                
                                
                                //MARK: check if movie info count matches movie ID count
                                self.movieLoadCount += 1
                                if self.movieLoadCount == self.idArray.count {
                                    
                                    //self.updateDisplay()
                                }
                            }
                        }
                    }
                    }.resume()
            }
        }
    }
    
    
    
    //MARK: - ========= Create Movie File======
    func newMovie(withID id:Int, title:String, imageUrl:String, genres:[String], desc:String, rtScore:Int, imdbScore:Double, trailerUrl:String)->Movie {
        let movie = Movie()
        movie.imageUrl = imageUrl
        movie.title = title
        movie.genres = genres.asList()
        movie.desc = desc
        movie.rtScore = rtScore
        movie.imdbScore = imdbScore
        movie.id = id
        movie.trailerUrl = trailerUrl
        return movie
    }
    
    
}
