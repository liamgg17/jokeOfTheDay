//
//  NetworkManager.swift
//  JokeApp
//
//  Created by Christian Martinez on 10/11/22.
//

import Foundation
import Alamofire

enum NetworkManager{
    
  
    struct Error {
        
        static let networkError: String = "Problema en la conexión a Internet. Inténtalo de nuevo."
        static let internalError: String = "Ups, ha ocurrido un error. Inténtalo de nuevo"
    }
    
    
    static var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    
    enum LocalizedError: String {
        case networkError
        case internalError
        
        var description: String {
            switch self {
            case .networkError:
                return Error.networkError
            case .internalError:
                return Error.internalError
            }
        }
    }
    
    case error(NetworkManager.LocalizedError)
    
    // MARK: - Properties
    
    var localizedDescription: String {
        switch self {
        case .error(let error):
            return error.description
        }
    }
    
    var type: LocalizedError {
        switch self {
        case .error(let errorType):
            return errorType
        }
    }
    
    // MARK: - Init
    
    init(_ error: Error?) {
        
        guard let errorCode = error,
            NetworkManager.isConnectedToInternet else {
                self = .error(.networkError)
                return
        }
        
        switch errorCode {
        default:
            self = .error(.internalError)
        }
    }
}

