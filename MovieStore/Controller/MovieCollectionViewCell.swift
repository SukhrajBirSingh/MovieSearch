//
//  MovieCollectionViewCell.swift
//  MovieStore
//
//  Created by Admin on 2022-01-17.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieYear : UILabel!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    func setup(with movie : Movie){
        let url = movie.Poster
      guard  let data = try? Data(contentsOf: URL(string: url)!)else {return}
           
        DispatchQueue.main.async {
            self.movieImageView.image = UIImage(data: data)
            self.movieTitle.text = movie.Title
            self.movieYear.text = movie.Year
        }
            

        
    }
}

