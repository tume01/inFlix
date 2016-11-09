//
//  FavoriteMovieCollectionViewCell.swift
//  inFlix
//
//  Created by Franco Tume on 11/8/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import UIKit

protocol FavoriteMovieCollectionViewCellDelegate: class {
    func favoriteMovieCollectionViewCellDidPressButton(_ favoriteMovie: FavoriteMovieCollectionViewCell)
}

class FavoriteMovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    weak var delegate: FavoriteMovieCollectionViewCellDelegate?
    
    
    var favoriteMovie: Movie? {
        didSet {
            configureView()
        }
    }
    
    @IBAction func pressButton(_ sender: Any) {
        delegate?.favoriteMovieCollectionViewCellDidPressButton(self)
    }
    
    func configureView() {
        if let favoriteMovie = favoriteMovie {
            if let titleText = titleText,
                let yearLabel = yearLabel,
                let moviePoster = moviePoster{
                
                titleText.text = favoriteMovie.showTittle
                yearLabel.text = favoriteMovie.releaseYear
                
                NetworkManager.sharedInstance().getDataFromUrl(url: URL(string: favoriteMovie.posterURL)!) {
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
}
