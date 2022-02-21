//
//  ApiResponse.swift
//  MovieStore
//
//  Created by Admin on 2022-02-19.
//

import Foundation
struct ApiResponse <T:Codable> : Codable {
    let Search : [Movie]
    let Response : String?
    let Error : String?
    
}
