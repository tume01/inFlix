//
//  MovieListTableViewCell.swift
//  inFlix
//
//  Created by Franco Tume on 11/4/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    
    var detailMovie: Movie? {
        didSet {
           setUpCell()
        }
    }
    
    @IBOutlet weak var movieTittle: UILabel!
    @IBOutlet weak var movieDetail: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell() {
        if let detailMovie = detailMovie {
            if let movieTittle = movieTittle,
                let movieDetail = movieDetail,
                let movieImage = movieImage {
                movieTittle.text = detailMovie.showTittle
                movieDetail.text = detailMovie.releaseYear
            }
        }
    }
}
