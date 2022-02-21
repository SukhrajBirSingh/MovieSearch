//
//  AppErrors.swift
//  MovieStore
//
//  Created by Admin on 2022-02-19.
//

import Foundation
import UIKit
enum AppError : LocalizedError{
    case errorDecoding
    case unkonwnError
    case invalidUrl
    case serverError(String)
    
    var errorDescription: String?{
        switch self{
            
    
        case .errorDecoding:
            return ("Response could not be decoded")
        case .unkonwnError:
            return "unknown error"
        case .invalidUrl:
            return "Please give a valid URL"
        case .serverError(let error):
            return error
        }
        
    }
}
