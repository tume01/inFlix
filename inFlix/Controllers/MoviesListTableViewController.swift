//
//  MoviesListTableViewController.swift
//  inFlix
//
//  Created by Franco Tume on 11/4/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import UIKit
enum Filter: String {
    case actor = "Actor"
    case title = "Tittle"
    case director = "Director"
}

class MoviesListTableViewController: UITableViewController {
    
    let backgroundColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
    let tintColor = UIColor(red:0.73, green:0.04, blue:0.04, alpha:1.0)
    let searchController = CustomUISearchController(searchResultsController: nil)
    var filteredMovies = [Movie]()
    let filters = [
        Filter.actor.rawValue,
        Filter.title.rawValue,
        Filter.director.rawValue
    ]
    
    var activityIndicator = UIActivityIndicatorView()
    
    var cachedImages = NSCache<NSString, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpActivityIndicator()
        setUpSearchController()
    }
    
    func setUpView() {
        self.tableView.backgroundColor = backgroundColor
        tableView.backgroundView = UIView()
    }
    
    func setUpActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.color = tintColor
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        self.view.addSubview(activityIndicator)
    }
    
    func setUpSearchController() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        tableView.backgroundView?.backgroundColor = backgroundColor
        tableView.headerView(forSection: 0)?.backgroundColor = backgroundColor
        
        searchController.definesPresentationContext = true
        searchController.extendedLayoutIncludesOpaqueBars = true
        
        searchController.searchBar.scopeButtonTitles = filters
        searchController.searchBar.barTintColor = backgroundColor
        searchController.searchBar.tintColor = tintColor
        searchController.searchBar.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredMovies.count
        }
        
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListaTableViewCell", for: indexPath) as! MovieListTableViewCell

        let movie: Movie
        movie = filteredMovies[indexPath.row]
        cell.detailMovie = movie
        cell.delegate = self
        
        if let cachedImage = cachedImages.object(forKey: movie.posterURL as NSString) {
            cell.movieImage.image = cachedImage
        }else {
            NetworkManager.sharedInstance().getDataFromUrl(url: URL(string: movie.posterURL)!) {
                networkResult in
                switch networkResult {
                case .success(let result):
                    if let posterImage = UIImage(data: result as! Data) {
                        if(movie.posterURL == cell.detailMovie?.posterURL) {
                            cell.movieImage.image = posterImage
                        }
                        self.cachedImages.setObject(posterImage, forKey: movie.posterURL as NSString)
                    }else {
                        cell.movieImage.image = #imageLiteral(resourceName: "noImage")
                    }
                case .error(let error):
                    print(error)
                    cell.movieImage.image = #imageLiteral(resourceName: "noImage")
                }
            }
        }
        cell.movieImage.contentMode = UIViewContentMode.scaleAspectFill
        return cell
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "Tittle") {
        let scopeFilter: Filter = Filter(rawValue: scope)!
        let scope: String
        
        switch scopeFilter {
        case .actor:
            scope = "actor"
        case .title:
            scope = "title"
        case .director:
            scope = "director"
        }
        
        let filters = [
            scope: searchText
        ]
        
        activityIndicator.startAnimating()
        MoviesService.sharedInstance().getMovies(filters: filters) {
            networkResult in
            DispatchQueue.main.async {
                self.filteredMovies = []
                self.activityIndicator.stopAnimating()
                switch networkResult {
                case .success(let result):
                    self.filteredMovies = result as! [Movie]
                case .error(let error):
                    print(error)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func cleanSearch() {
        filteredMovies.removeAll()
        tableView.reloadData()
    }
}

extension MoviesListTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        if(searchBar.text != "" && (searchBar.text?.characters.count)! >= 5) {
            filterContentForSearchText(searchText: searchController.searchBar.text!, scope: scope)
        }
    }
}

extension MoviesListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        cleanSearch()
        if(searchBar.text != "") {
            filterContentForSearchText(searchText: searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
        }
    }
}

extension MoviesListTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let movie = filteredMovies[indexPath.row]
                let controller = segue.destination as! MovieViewController
                controller.detailMovie = movie
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}

extension MoviesListTableViewController: MoviesListTableViewCellDelegate {
    func MovieListTableViewCellDidPressButton(_ movieCell: MovieListTableViewCell) {
        
        let newState = !movieCell.favoriteButton.isSelected
        
        if(newState) {
            MoviesService.sharedInstance().addFavoriteMovie(movie: movieCell.detailMovie!)
        }else {
            MoviesService.sharedInstance().removeFavoriteMovie(movie: movieCell.detailMovie!)
        }
        
        UIView.animate(withDuration: 0.1 ,
                       animations: {
                        movieCell.favoriteButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        },
                       completion: { finish in
                        UIView.animate(withDuration: 0.2){
                            movieCell.favoriteButton.isSelected = newState
                            movieCell.favoriteButton.transform = CGAffineTransform.identity
                        }
        })
    }
}

extension MoviesListTableViewController: ScrollableToTopView {
    func scrollToTop() {
        if isViewLoaded && (view.window != nil) {
            tableView.setContentOffset(CGPoint(x: 0, y: -topLayoutGuide.length), animated: true)
        }
    }
}

class CustomUISearchController: UISearchController {
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
