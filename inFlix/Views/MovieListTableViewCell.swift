//
//  MovieListTableViewCell.swift
//  inFlix
//
//  Created by Franco Tume on 11/4/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import UIKit

protocol MoviesListTableViewCellDelegate: class {
    func MovieListTableViewCellDidPressButton(_ movieCell: MovieListTableViewCell)
}

class MovieListTableViewCell: UITableViewCell {
    
    var detailMovie: Movie? {
        didSet {
           setUpCell()
        }
    }
    
    @IBOutlet weak var movieTittle: UILabel!
    @IBOutlet weak var movieDetail: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieDirector: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate: MoviesListTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setUpCell() {
        backgroundColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
        if let detailMovie = detailMovie {
            if let movieTittle = movieTittle,
                let movieDetail = movieDetail,
                let movieImage = movieImage {
                movieTittle.text = detailMovie.showTittle
                movieDetail.text = detailMovie.releaseYear
                movieDirector.text = detailMovie.director
                movieImage.image = #imageLiteral(resourceName: "noImage")
                setUpButton()
            }
        }
    }
    
    func setUpButton() {
        favoriteButton.setBackgroundImage(#imageLiteral(resourceName: "whiteHeart"), for: .normal)
        favoriteButton.setBackgroundImage(#imageLiteral(resourceName: "favoriteBar"), for: .selected)
        favoriteButton.setBackgroundImage(#imageLiteral(resourceName: "favoriteBar"), for: [.selected, .highlighted])
        favoriteButton.isSelected = detailMovie?.isFavorite ?? false
    }

    @IBAction func saveFavorite(_ sender: Any) {
        delegate?.MovieListTableViewCellDidPressButton(self)
    }
    
}
