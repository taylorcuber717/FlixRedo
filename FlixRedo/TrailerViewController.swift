//
//  TrailerViewController.swift
//  FlixRedo
//
//  Created by Taylor McLaughlin on 6/13/19.
//  Copyright © 2019 Taylor McLaughlin. All rights reserved.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController {
    
    var trailerView: WKWebView!
    var movie: [String:Any]!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        let webViewExit = UISwipeGestureRecognizer(target: self, action: #selector(self.leftSwipe))
        trailerView = WKWebView(frame: .zero, configuration: webConfiguration)
        trailerView.uiDelegate = self as? WKUIDelegate
        trailerView.addGestureRecognizer(webViewExit)
        view = trailerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let movieId = movie["id"]!
        let videoURL = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
        let request = URLRequest(url: videoURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                print(dataDictionary)
                let trailers = dataDictionary["results"] as! [[String:Any]]
                let trailerKey = trailers[0]["key"]!
                let trailerURL = URL(string: "https://www.youtube.com/watch?v=\(trailerKey)")
                let trailerRequest = URLRequest(url: trailerURL!)
                self.trailerView.load(trailerRequest)
                
            }
        }
        task.resume()
        
    }
    
    @objc func leftSwipe() {
        performSegue(withIdentifier: "ReturnSegue", sender: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let movieDetailsViewController = segue.destination as! MovieDetailsViewController
//        movieDetailsViewController.movie = movie
//    }

}
