//
//  MovieDetailsViewController.swift
//  FlixRedo
//
//  Created by Taylor McLaughlin on 6/11/19.
//  Copyright © 2019 Taylor McLaughlin. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    var movie: [String:Any]!

    @IBAction func posterTapped(_ sender: Any) {
        performSegue(withIdentifier: "TrailerSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        
        titleLabel.text = movie["title"] as? String
        overviewLabel.text = movie["overview"] as? String
        posterView.af_setImage(withURL: posterUrl!)
        backdropView.af_setImage(withURL: backdropUrl!)
        
        print(movie)
        

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let trailerViewController = segue.destination as! TrailerViewController
        trailerViewController.movie = movie
        
    }
    

}
