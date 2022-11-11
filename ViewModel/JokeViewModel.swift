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
    
    func updateJoke() {
        
        jokeRemoteManager.fetchJoke(completion: { (jokeResult, error) in
            
            if let error = error {
                print(error)
                
            } else {
                if let jokeResult = jokeResult {
                    
                    self.joke = jokeResult
                    self.parseJoke()
                   
                }
            }
        })
        
    }
    
    private func parseJoke() {
        
        if self.joke?.type == "twopart" {
            
            if let setup = self.joke?.setup, let delivery = self.joke?.delivery {
                self.joke?.joke = "\(setup) \n \n \(delivery)"
                
            }
            
        }
        self.delegate?.didUpdateJoke()
      
        
    }
    
}


