//
//  Router.swift
//  JTMovies
//
//  Created by Jeff Tabios on 24/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation
import Networking

protocol APIProtocol{
    func request<U:Codable>(endPoint: EndPoint, completion: @escaping (U?)->Void)
    func decode<U:Decodable>(completion: @escaping (U?)->Void)
}

class API:APIProtocol{
    private var response:SuccessJSONResponse?
    
    func request<U:Codable>(endPoint: EndPoint, completion: @escaping (U?)->Void){
        
        let networking = Networking(baseURL: endPoint.baseURL)
        networking.headerFields = endPoint.headers
        
        switch endPoint.httpMethod {
        case .get:
            networking.get(endPoint.path,parameters:endPoint.params){[weak self](result) in
                switch result{
                case .success(let response):
                    self?.response = response
                    self?.decode(completion: completion)
                case .failure:
                    completion(nil)
                }
            }
        case .post:
            break
        case .delete:
            break
        case .put:
            break
        case .patch:
            break
        }
    }
    
    func decode<U:Decodable>(completion: @escaping (U?)->Void){
        if let response = response {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            guard let result = try? decoder.decode(U.self, from: response.data) else{
                completion(nil)
                return
            }
            completion(result)
        }else{
            completion(nil)
        }
    }
}
