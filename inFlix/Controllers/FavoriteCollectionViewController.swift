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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        cell.favoriteMovie = favoriteMovies[indexPath.row]
        cell.delegate = self
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
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
