//
//  JokeRemoteDataManager.swift
//  JokeApp
//
//  Created by Christian Martinez on 10/11/22.
//

import Foundation
import Alamofire

struct MovieService {
    

    func fetchJoke(completion: @escaping (Joke?, Error?) -> ()) {
           
        Alamofire.request(ApiSettings.ApiBaseUrl).responseMovie { response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            if let movie = response.result.value {
                completion(movie, nil)
                return
            }
        }
    }
}
