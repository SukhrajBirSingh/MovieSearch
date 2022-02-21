//
//  SearchViewController.swift
//  MovieStore
//
//  Created by Admin on 2022-02-06.
//

import UIKit

class SearchViewController : UIViewController {
        
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton : UIButton!
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        //searchTextField.text!
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        searchButton.tintColor = UIColor.white
        
        //searchButton.backgroundColor = UIColor.white
        searchTextField.delegate = self
        let url = "https://www.wallpaperup.com/uploads/wallpapers/2015/12/12/858387/4b8a92b93fc6b6a5a91175fdc7692d3c-1000.jpg"
        
        
        if let data = try? Data(contentsOf: URL(string: url)!){
            view.backgroundColor = UIColor(patternImage: (UIImage(data: data) ?? UIImage(named: "a"))!).withAlphaComponent(0.7)
          }
        
//        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.addSubview(blurEffectView)
        // Do any additional setup after loading the view.
    }
    
}

extension SearchViewController : UITextFieldDelegate{
    
    //User pressed return key on Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        
        return true
    }
    
    
    
    //User deselect the text field
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }else {
            textField.placeholder = "Type something..."
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.performSegue(withIdentifier: "goToMovieView", sender: self)
        searchTextField.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMovieView" {
            let destinationVC = segue.destination as! MovieViewController
            destinationVC.searchedMovie = searchTextField.text
            //destinationVC.searched(text: searchTextField.text)
           // destinationVC.movies =
        }
    }
    
}
