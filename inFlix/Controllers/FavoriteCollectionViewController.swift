//
//  FavoriteCollectionViewController.swift
//  inFlix
//
//  Created by Franco Tume on 11/8/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import UIKit

private let reuseIdentifier = "FavoriteMovieCollectionViewCell"

class FavoriteCollectionViewController: UICollectionViewController {
    
    var favoriteMovies = [Movie]()
    
    var cachedImages = NSCache<NSString, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        loadFavoriteMovies()
    }
    
    func loadFavoriteMovies() {
       favoriteMovies =  MoviesService.sharedInstance().favoriteMovies
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteMovies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FavoriteMovieCollectionViewCell
        let favoriteMovie = favoriteMovies[indexPath.row]
        cell.favoriteMovie = favoriteMovie
        
        if let cachedImage = cachedImages.object(forKey: favoriteMovie.posterURL as NSString) {
            cell.moviePoster.image = cachedImage
        }else {
            NetworkManager.sharedInstance().getDataFromUrl(url: URL(string: favoriteMovie.posterURL)!) {
                networkResult in
                switch networkResult {
                case .success(let result):
                    if let posterImage = UIImage(data: result as! Data) {
                        cell.moviePoster.image = posterImage
                    }else {
                        cell.moviePoster.image = #imageLiteral(resourceName: "noImage")
                    }
                case .error(let error):
                    print(error)
                    cell.moviePoster.image = #imageLiteral(resourceName: "noImage")
                }
            }
        }
        cell.moviePoster.contentMode = UIViewContentMode.scaleAspectFill
        cell.delegate = self
        return cell
    }
  
    override func viewWillAppear(_ animated: Bool) {
        loadFavoriteMovies()
        self.collectionView?.reloadData()
    }
}

extension FavoriteCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width / 2) - 10, height: 300)    }
}

extension FavoriteCollectionViewController: FavoriteMovieCollectionViewCellDelegate {
    func favoriteMovieCollectionViewCellDidPressButton(_ favoriteMovie: FavoriteMovieCollectionViewCell) {
        let selectedMovie = collectionView?.indexPath(for: favoriteMovie)
        
        MoviesService.sharedInstance().removeFavoriteMovie(movie: favoriteMovies[(selectedMovie?.row)!])
        favoriteMovies.remove(at: (selectedMovie?.row)!)
        collectionView?.deleteItems(at: [selectedMovie!])
    }
}

extension FavoriteCollectionViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailFavorite" {
            if let favoriteMovieCell = sender as? FavoriteMovieCollectionViewCell {
                let movie = favoriteMovieCell.favoriteMovie
                let controller = segue.destination as! MovieViewController
                controller.detailMovie = movie
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}
