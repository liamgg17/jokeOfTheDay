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
    

    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        
        if let nswf = self.joke?.flags.nsfw {
            dictionary["nsfw"] = nswf
        }
        if let religious = self.joke?.flags.religious {
            dictionary["religious"] = religious
        }
        if let political = self.joke?.flags.political {
            dictionary["political"] = political
        }
        if let racist = self.joke?.flags.racist {
            dictionary["racist"] = racist
        }
        if let sexist = self.joke?.flags.sexist {
            dictionary["sexist"] = sexist
        }
        if let explicit = self.joke?.flags.explicit {
            dictionary["explicit"] = explicit
        }
    
        return dictionary
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


