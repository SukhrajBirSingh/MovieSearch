//
//  MovieDetialViewController.swift
//  MovieStore
//
//  Created by Admin on 2022-02-06.
//

import UIKit

class MovieDetialViewController: UIViewController {
    
    var selectedMovie : Movie?
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var posterImage : UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = selectedMovie?.Poster
        guard  let data = try? Data(contentsOf: URL(string: url!)!)else {return}
        DispatchQueue.main.async {
            self.posterImage.image = UIImage(data: data)
            self.title = self.selectedMovie?.Title

        }
        
        // Do any additional setup after loading the view.
    }
  

}
