//
//  LikedMoviesVC.swift
//  FilmSwipe
//
//  Created by Dylan Southard on 2018/06/11.
//  Copyright © 2018 Dylan Southard. All rights reserved.
//

import UIKit

class LikedMoviesVC: NavSubview {

    //MARK: - =========IBOUTLETS==========
    
    @IBOutlet weak var movieTable: UITableView!
    
    //MARK: - =========Variables==========
    
    
    
    //MARK: - ==========VIEW SETUP==========
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Delegates/Datasources
        self.movieTable.delegate = self
        self.movieTable.dataSource = self
    }
}

//MARK: - ==========TABLE VIEW==========
//MARK: - ==DElEGATE==
extension LikedMoviesVC : UITableViewDelegate {
    
}

//MARK: - ==DATASOURCE==
extension LikedMoviesVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.container.dataManager.likedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        let movie = self.container.dataManager.likedMovies[indexPath.row]
        //TODO: GET THUMBNAIL IMAGE  cell.imageView!.image = movie.thumbnail
        cell.textLabel!.text = movie.title
        return cell
    }
    
}




