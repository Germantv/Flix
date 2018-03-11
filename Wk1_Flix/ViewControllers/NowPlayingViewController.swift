//
//  NowPlayingViewController.swift
//  Wk1_Flix
//
//  Created by German Flores on 2/5/18.
//  Copyright © 2018 German Flores. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import Foundation
import PKHUD


class NowPlayingViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var movies: [Movie] = []
    var refreshControl: UIRefreshControl!
    
    let alert = UIAlertController(title: "Warning", message: "No internet connection", preferredStyle: .alert)
    /*
     class Connectivity {
     class func isConnectedToNet() -> Bool {
     return NetworkReachabilityManager()!.isReachable
     }
     }
     */
    
    // to commit 
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
         if Connectivity.isConnectedToNet() {
         present(alert, animated: true, completion: nil)
         }
         */
        
        //activityIndicator.startAnimating()
        HUD.dimsBackground = false
        HUD.allowsInteraction = false
        
        HUD.flash(.progress, onView: tableView, delay: 0.7) { finished in
            // Completion Handler
            HUD.flash(.success, onView: self.tableView)
        }
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.dataSource = self
        self.tableView.estimatedRowHeight = 175
        
        fetchMovies()
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchMovies()
    }
    
    func fetchMovies() {
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.movie = movies[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
