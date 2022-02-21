//
//  StringtoURL+Extension.swift
//  MovieStore
//
//  Created by Admin on 2022-02-19.
//

import Foundation

extension String {
    var asURL : URL?{
        return URL(string: self)
    }
}
