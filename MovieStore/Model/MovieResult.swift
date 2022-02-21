//
//  MovieData.swift
//  MovieStore
//
//  Created by Admin on 2022-02-06.
//

import Foundation

struct MovieResult : Codable{
    let Search : [Movie]?
    let Response : String?
    let Error : String?
  
}

struct Movie: Codable{

    let Title: String
    let Year: String
    let imdbID: String
    let _Type : String
    let Poster : String

    private enum CodingKeys : String , CodingKey {
        case Title, Year, imdbID, _Type = "Type", Poster
    }
}
