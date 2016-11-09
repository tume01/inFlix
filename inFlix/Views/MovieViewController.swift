//
//  MovieViewController.swift
//  inFlix
//
//  Created by Franco Tume on 11/7/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var detailMovie: Movie? {
        didSet {
            setupView()
        }
    }
    
    func setupView() {
        if let detailMovie = self.detailMovie {
            if let titleLabel = titleLabel,
                let directorLabel = directorLabel,
                let yearLabel = yearLabel,
                let castLabel = castLabel,
                let category = category,
                let ratingLabel = ratingLabel,
                let moviePoster = moviePoster{
                
                titleLabel.text = detailMovie.showTittle
                directorLabel.text = detailMovie.director
                yearLabel.text = detailMovie.releaseYear
                castLabel.text = detailMovie.showCast
                category.text = detailMovie.category
                ratingLabel.text = detailMovie.rating
                
                NetworkManager.sharedInstance().getDataFromUrl(url: URL(string: detailMovie.posterURL)!) {
                    networkResult in
                    switch networkResult {
                    case .success(let result):
                        moviePoster.image = UIImage(data: result as! Data)
                    case .error(let error):
                        print(error)
                    }
                }
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
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
