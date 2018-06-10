//
//  ViewController.swift
//  FilmSwipe
//
//  Created by Dylan Southard on 2018/06/07.
//  Copyright © 2018 Dylan Southard. All rights reserved.
//




/*
 Todo:
 Make a settings view to populate query peram variables then remove preset test query variables
 Connect selected movie data to UI
 Prepopulate backup movie
 Add check if movie is in the like or dislike array before displaying
 need to get country query codes from themoviedatabase.com
 rerun the getmovieids() func when user is getting close to the end of the movie list
 
 
 
 */



import UIKit
import Koloda
import pop

class ViewController: UIViewController {
   
    @IBOutlet weak var kolodaView: KolodaView!
    
    var images = [#imageLiteral(resourceName: "cat"),#imageLiteral(resourceName: "cat2"),#imageLiteral(resourceName: "cat3"),#imageLiteral(resourceName: "cat4"),#imageLiteral(resourceName: "cat5")]
    
    
    
    //Movie Info
    var titleArray = [String]()
    var descriptionArray = [String]()
    var idArray = [Int]()
    var posterArray = [String]()
    var trailerArray = [String]()
    var urlString = String()
    var trailerURLString = String()
    
    //Movie Count
    var movieCount = Int()
    var movieLoadCount = Int()
    var pageCount = Int()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.kolodaView.delegate = self
        self.kolodaView.dataSource = self
        
        self.pageCount = 1
        querySetup()
    }

    func querySetup(){
        
        //preset test Query
        //-------------Get rid of these after creating settings view--------------------//
        Vars.genre = "Comedy"
        Vars.country = "US"
        Vars.releaseYear = "1985"
        Vars.sortType = "Popularity"
        //--------------fuck-----cunt-----taco-------tits-------------------------------//
        
        //base string
        self.urlString = "https://api.themoviedb.org/3/discover/movie?api_key=7f8097fbd3d28753af1c79372d180dd4"
        
        //genre
        if Vars.genre != "" {
            switch Vars.genre
            {
            case "Action":
                Vars.genreID = "28"
            case "Adventure":
                Vars.genreID = "12"
            case "Animation":
                Vars.genreID = "16"
            case "Comedy":
                Vars.genreID = "35"
            case "Crime":
                Vars.genreID = "80"
            case "Documentary":
                Vars.genreID = "99"
            case "Drama":
                Vars.genreID = "18"
            case "Family":
                Vars.genreID = "10751"
            case "Fantasy":
                Vars.genreID = "14"
            case "History":
                Vars.genreID = "36"
            case "Horror":
                Vars.genreID = "27"
            case "Music":
                Vars.genreID = "10402"
            case "Mystery":
                Vars.genreID = "9648"
            case "Romance":
                Vars.genreID = "10749"
            case "Science Fiction":
                Vars.genreID = "878"
            case "TV Movie":
                Vars.genreID = "10770"
            case "Thriller":
                Vars.genreID = "53"
            case "War":
                Vars.genreID = "10752"
            case "Western":
                Vars.genreID = "37"
            default:
                break
            }
            self.urlString = self.urlString + "&genre/\(Vars.genreID)/movies?"
        }
        
        //country
        //-------------need more countries---Merika #1 Trump rulz--------------//
        if Vars.country != "" {
            switch Vars.country
            {
            case "US":
                Vars.countryQuery = "&certification_country=US&"
            default:
                break
            }
            self.urlString = self.urlString + Vars.countryQuery
        }
        
        //release year like a mutha fucka
        if Vars.releaseYear != "" {
            self.urlString = self.urlString + "&primary_release_year=\(Vars.releaseYear)&"
        }
        
        //sorting shit and twats
        if Vars.sortType != "" {
            switch Vars.sortType {
            case "Popularity":
                Vars.sortQuery = "&sort_by=popularity.desc"
            case "Release Date":
                Vars.sortQuery = "&sort_by=release_date.desc"
            case "Revenue":
                Vars.sortQuery = "&sort_by=revenue.desc"
            default:
                break
            }
            self.urlString = self.urlString + Vars.sortQuery
        }
        
        getMovieIDs()
        
    }
    
    
    
    //get 20 movie titles and IDs
    func getMovieIDs(){
        
        self.urlString = self.urlString + "&page=\(self.pageCount)"
        
        URLSession.shared.dataTask(with: URL(string: self.urlString)!) { (data, response, error) in
            if  data != nil {
                let responseString = String(data: data!, encoding: .utf8)!
                if(responseString != ""){
                    let responseValues = responseString.toDictionary()
                    
                    DispatchQueue.main.async {
                        self.titleArray.append(contentsOf: Array(responseValues.mutableArrayValue(forKeyPath: "results.title")) as! [String])
                        self.idArray.append(contentsOf: Array(responseValues.mutableArrayValue(forKeyPath: "results.id")) as! [Int])
                        
                        print(self.titleArray.count)
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
                
                
                URLSession.shared.dataTask(with: URL(string: "http://api.themoviedb.org/3/movie/\(self.idArray[self.movieLoadCount])/videos?api_key=7f8097fbd3d28753af1c79372d180dd4")!) { (data, response, error) in
                    if  data != nil {
                        let responseString = String(data: data!, encoding: .utf8)!
                        if(responseString != ""){
                            let responseValues = responseString.toDictionary()
                            
                            DispatchQueue.main.async {
                                
                                self.trailerURLString = String(describing: responseValues.value(forKeyPath: "results.key")!).replacingOccurrences(of: "[\"\'\\[\\]^+<>()]", with: "", options: .regularExpression, range: nil).trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: ",").first!
                                let tempTrailerIdArray =  self.trailerURLString.components(separatedBy: ",")
                                self.trailerArray.append("https://www.youtube.com/embed/\(tempTrailerIdArray[0])")
                                print(self.trailerArray[0])
                            }
                        }
                    }
                    }.resume()
                
                URLSession.shared.dataTask(with:URL(string: "https://api.themoviedb.org/3/movie/\(self.idArray[self.movieLoadCount])?api_key=7f8097fbd3d28753af1c79372d180dd4&append_to_response=credits")!) { (data, response, error) in
                    if  data != nil {
                        let responseString = String(data: data!, encoding: .utf8)!
                        if(responseString != ""){
                            let responseValues = responseString.toDictionary()
                            DispatchQueue.main.async {
                                
                                //get Description
                                if responseValues.value(forKeyPath: "overview") != nil {
                                    self.descriptionArray.append(responseValues.value(forKeyPath: "overview") as! String)
                                }else{
                                    //load default overview
                                }
                                
                                //get poster path
                                if responseValues.value(forKeyPath: "poster_path") != nil {
                                    self.posterArray.append("https://image.tmdb.org/t/p/w200\(responseValues.value(forKeyPath: "poster_path") as! String)")
                                }else{
                                    //load default image
                                }
                                
                                //check if movie info count matches movie ID count
                                if self.descriptionArray.count == self.idArray.count {
                                    self.updateDisplay()
                                }
                            }
                        }
                    }
                    }.resume()
                
                self.movieLoadCount += 1
            }
        }
        
        
        
    }
    
    func updateDisplay(){
        
        //----------------uncomment after attaching to UI--------------------//
        
        //display title
      //  self.titleView.text = self.titleArray[self.movieCount]
        //display description
      //  self.descriptionView.text = self.descriptionArray[self.movieCount]
        //load trailer
     //   self.webView.loadRequest(URLRequest(url: URL(string: self.trailerArray[self.movieCount])!))
        //display poster
        let data = try? Data(contentsOf: URL(string: self.posterArray[self.movieCount])!)
        if let imageData = data {
            let image = UIImage(data: imageData)
     //       self.imageView?.image = image
        }
        
        
        //setup backup movie
        //display title
        //  self.titleView2.text = self.titleArray[self.movieCount + 1]
        //display description
        //  self.descriptionView2.text = self.descriptionArray[self.movieCount + 1]
        //load trailer
        //   self.webView2.loadRequest(URLRequest(url: URL(string: self.trailerArray[self.movieCount + 1])!))
        //display poster
        let data2 = try? Data(contentsOf: URL(string: self.posterArray[self.movieCount + 1])!)
        if let imageData = data {
            let image = UIImage(data: imageData)
            //       self.imageView2?.image = image
        }
        
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



//Extension to parse JSON 
extension String{
    func toDictionary() -> NSDictionary {
        let blankDict : NSDictionary = [:]
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
            } catch {
                print(error.localizedDescription)
            }
        }
        return blankDict
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
            
            Vars.likedDescArray.append(self.titleArray[self.movieCount])
            Vars.likedIDArraay.append(self.idArray[self.movieCount])
            Vars.likedTitleArray.append(self.titleArray[self.movieCount])
            Vars.likedTrarilerArray.append(self.trailerArray[self.movieCount])
            Vars.likedPosterArray.append(self.posterArray[self.movieCount])
            
            self.movieCount += 1
            
        case .left:
            print("left")
            
            Vars.dislikeIDArray.append(self.idArray[self.movieCount])
            self.movieCount += 1
            
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



