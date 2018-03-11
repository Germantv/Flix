//
//  Movie.swift
//  Wk1_Flix
//
//  Created by German Flores on 3/9/18.
//  Copyright © 2018 German Flores. All rights reserved.
//

import Foundation
import PKHUD
import AlamofireImage
import Alamofire
import UIKit

class Movie {
    var title: String
    var posterUrl: URL?
    var posterPath: String
    var overview: String
    var releaseDate: String
    var backdropPath: String
    var backdropUrl: URL?
    var id: Int
    let baseURL = "https://image.tmdb.org/t/p/w500"
    
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No Title"
        posterPath = dictionary["poster_path"] as! String
        overview = dictionary["overview"] as! String
        posterUrl = URL(string: baseURL + posterPath)!
        releaseDate = dictionary["release_date"] as! String
        backdropPath = dictionary["backdrop_path"] as! String
        backdropUrl = URL(string: baseURL + backdropPath)!
        id = dictionary["id"] as! Int
    }
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        return movies
    }
}
