//
//  JokeViewModel.swift
//  JokeApp
//
//  Created by Christian Martinez on 10/11/22.
//

import Foundation


protocol JokeViewModelProtocol {
    func didUpdateJoke()
}

class JokeViewModel: NSObject {
    
    
    
    var delegate: JokeViewModelProtocol?
    fileprivate(set) var joke: JokeModel?
    
    private var jokeRemoteManager = JokeRemoteDataManager()
    
    
    func updateJoke(completion: @escaping (_ success:Bool?) -> ()) {
       
        jokeRemoteManager.fetchJoke(completion: { (jokeResult, error) in
            
            if let error = error {
                print(error)
                completion(false)
                
            } else {
                if let jokeResult = jokeResult {
                
                    self.joke = jokeResult
                    self.parseJoke()
                    completion(true)
                }
            }
        })
        
        
    }
    
    /**
     That property is responsible of verifying if there is an internet connection
        :returns: True or False depending on whether there is a connection or not
        
    */
    
    var shouldGetJoke: Bool {
       
        let isConnectedToInternet: Bool = NetworkManager.isConnectedToInternet
        return isConnectedToInternet
    }
    
  
    private func parseJoke() {
        
        if self.joke?.type == "twopart" {
            
            if let setup = self.joke?.setup, let delivery = self.joke?.delivery {
                self.joke?.joke = "\(setup)\n\n\(delivery)"
                
            }
            
        }
         
        self.delegate?.didUpdateJoke()
        
    }
    
}


