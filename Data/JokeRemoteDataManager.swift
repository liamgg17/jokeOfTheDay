//
//  JokeRemoteDataManager.swift
//  JokeApp
//
//  Created by Christian Martinez on 10/11/22.
//

import Foundation
import Alamofire

struct JokeRemoteDataManager {
    
    
    /**
     Function that is responsible for making the request to the Server to obtain the Joke to show
        :params:
        :returns: success JSON object with the information
        
    */
    

    func fetchJoke(completion: @escaping (JokeModel?, Error?) -> ()) {
           
        Alamofire.request(ApiSettings.ApiBaseUrl).responseJoke { response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            if let joke = response.result.value {
                completion(joke, nil)
                return
            }
        }
    }
}
