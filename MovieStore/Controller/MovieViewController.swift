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
    
    func searched (text : String?){
      searchMovies(search: text)
    }
    
    
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var SearchBarView: UISearchBar!
    
    override func viewWillAppear(_ animated: Bool) {

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        SearchBarView.delegate = self
        self.view.backgroundColor = UIColor.gray
        collectionView.backgroundColor = UIColor.gray
        SearchBarView.barTintColor = UIColor.gray
        SearchBarView.searchTextField.backgroundColor = UIColor.white
        SearchBarView.searchBarStyle = .minimal
        
        SearchBarView.text = searchedMovie
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
    
    func searchMovies(search : String?) {
        DispatchQueue.main.async {
            self.collectionView.resignFirstResponder()

        }


        guard let text = search, !text .isEmpty else {
            return
        }

        let quary = text.replacingOccurrences(of: " ", with: "%20")

        movies.removeAll()

        URLSession.shared.dataTask(with: URL(string: "https://www.omdbapi.com/?s=\(quary)&apikey=("YOUR_API_KEY")")!,
             completionHandler: { data, response, error in

            guard let data = data, error == nil else {

                return
            }

            //convert
            var result: MovieResult?
            do {

                result = try JSONDecoder().decode(MovieResult.self, from: data)


            }catch{
                print ("movie not found! error")
               self.searchMovies(search: quary.components(separatedBy:"%20").first)
                return

            }

            guard let finalResult = result else{
                return
            }

            //update movie array
           let newMovies = finalResult.Search
            self.movies.append(contentsOf: newMovies)


            //refresh our table
            DispatchQueue.main.async {
                self.collectionView.reloadData()

            }

        }).resume()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        searchMovies(search:SearchBarView.text!)
        
       // searchMovies(search: SearchBarView.text)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
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


