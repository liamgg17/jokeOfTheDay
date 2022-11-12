//
//  JokeModel.swift
//  JokeApp
//
//  Created by Christian Martinez on 10/11/22.
//

import Foundation
import Alamofire

// MARK: - Struct

struct JokeModel: Codable {
    
    var error: Bool
    var category: String
    var type: String
    var setup: String?
    var delivery: String?
    var joke: String?
    let flags: Flags
    var id: Int
    var safe: Bool
    var lang: String
    
}

// MARK: - Flags

struct Flags: Codable {
    
    let nsfw: Bool
    let political: Bool
    let racist: Bool
    let religious: Bool
    let sexist: Bool
    let explicit: Bool
    
    var asDictionary : [String:Any] {
       let mirror = Mirror(reflecting: self)
       let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
         guard let label = label else { return nil }
         return (label, value)
       }).compactMap { $0 })
       return dict
     }
    
}



// MARK: - Alamofire response handlers

extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try JSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseJoke(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<JokeModel>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
