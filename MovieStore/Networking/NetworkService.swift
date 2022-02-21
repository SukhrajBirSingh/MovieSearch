//
//  NetworkService.swift
//  MovieStore
//
//  Created by Admin on 2022-02-19.
//

import Foundation
import UIKit

struct NetworkService {
    
    static let shared = NetworkService()
    private init() {}
    
    func fetchMovies (search : String, completion : @escaping(Result<MovieResult,Error>)->Void){
        request(route: .fetchMovies(search), method: .get, completion: completion)
    }
    
    
    
    
    func request<T:Codable> (route: Route, method: Method, completion : @escaping(Result<T, Error>)-> Void){
        
        guard let request = createRequest(route: route, method: method) else{
            completion(.failure(AppError.unkonwnError))
            return
            }
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result : Result<Data,Error>?
            
            if let data = data {
                result = .success(data)
               let responseString = String(data: data, encoding: .utf8) ?? "Could not stringify data"
                print("The response is: \(responseString)")
            }else if let error = error {
                result = .failure(error)
                print("the error is \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                self.handleResponse(result : result , completion : completion)
            }
            
        }.resume()
        
    }
    
    func handleResponse<T:Codable>(result : Result<Data,Error>?, completion : (Result<T,Error>)->Void ){
        
        guard let result = result else {
            completion(.failure(AppError.unkonwnError))
            return
        }
        
        switch result {
            
        case .success(let data):
            
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(T.self, from: data) else {
                
                completion(.failure(AppError.errorDecoding))
                return
            }
            
        
            completion(.success(response ))
               //print(response)
            

              //completion(.failure(AppError.unkonwnError))

            
            
        case .failure(let error):
            completion(.failure(error))
        }

        
    }
    
    

    func createRequest(route: Route, method : Method) -> URLRequest?{
        let urlString = Route.baseUrl + route.description
        //makesure there is URL
        guard let url = urlString.asURL else{return nil}
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.addValue("application/JSON", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
        
}
    
}
