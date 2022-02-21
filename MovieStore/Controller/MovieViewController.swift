//
//  ViewController.swift
//  MovieStore
//
//  Created by Admin on 2022-01-17.
//

import UIKit

class MovieViewController: UIViewController {

    var movies = [Movie]()
    var searchedMovie : String?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var SearchBarView: UISearchBar!
    
    override func viewWillAppear(_ animated: Bool) {

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        SearchBarView.delegate = self
        self.view.backgroundColor = UIColor.systemGray6
        collectionView.backgroundColor = UIColor.systemGray6
        SearchBarView.barTintColor = UIColor.gray
        SearchBarView.searchTextField.backgroundColor = UIColor.white
        SearchBarView.searchBarStyle = .minimal
        

        SearchBarView.text = searchedMovie
      
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkService.shared.fetchMovies(search: searchedMovie!) { (result) in
            switch result {
                
            case .success(let movies):
                if let newMovies = movies.Search{
                    self.movies.append(contentsOf: newMovies)
                    self.collectionView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }


}


extension MovieViewController : UICollectionViewDataSource{
    
   
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        cell.setup(with: movies[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       performSegue(withIdentifier: "goToMovieDetail", sender: self)
        
        }
        
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MovieDetialViewController
        if let indexPath = collectionView.indexPathsForSelectedItems?.first{
            destinationVC.selectedMovie = movies[indexPath.row]
        }
    }
    
}


extension MovieViewController : UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    let search =  SearchBarView.text

    guard let text = search, !text .isEmpty else {
                    return
                }
        
    let quary = text.replacingOccurrences(of: " ", with: "%20")
        

//                DispatchQueue.main.async {
//                self.collectionView.resignFirstResponder()
//    }
        movies.removeAll()
        
        NetworkService.shared.fetchMovies(search: quary) { (result) in
            switch result {
                
            case .success(let movies):
                if let foundMovies = movies.Search{
                    self.movies.append(contentsOf: foundMovies)
                    self.collectionView.reloadData()
                }
                else
                 {
                    if (quary.components(separatedBy: "%20").count >= 2 )  {
                        
                        let newQuary = quary.components(separatedBy: "%20").first
                        NetworkService.shared.fetchMovies(search: newQuary!) { (result) in
                            switch result {
                                
                            case .success(let movies):
                                if let newMovies = movies.Search{
                                    self.movies.append(contentsOf: newMovies)
                                    self.collectionView.reloadData()
                                } else {
                                    print ("movie still not found!")
                                }
                                
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                    }
                     else {
                        print ("movie not found")
                    }
                   
                    
                }
               
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
  
}

extension MovieViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10)
        }
    
    
}


