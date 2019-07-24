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
    func analyzeResult<U:Decodable>(result: JSONResult, completion: @escaping (U?)->Void)
}

struct API:APIProtocol{
    func request<U:Codable>(endPoint: EndPoint, completion: @escaping (U?)->Void){
        
        let networking = Networking(baseURL: endPoint.baseURL)
        networking.headerFields = endPoint.headers
        switch endPoint.httpMethod {
        case .get:
            networking.get(endPoint.path,parameters:endPoint.params){ (result) in
                self.analyzeResult(result: result, completion: completion)
            }
        case .post:
            networking.post(endPoint.path,parameters:endPoint.params){ (result) in
                self.analyzeResult(result: result, completion: completion)
            }
        case .delete:
            networking.delete(endPoint.path,parameters:endPoint.params){ (result) in
                self.analyzeResult(result: result, completion: completion)
            }
        case .put:
            break
        case .patch:
            break
        }
        
    }
    
    func analyzeResult<U:Decodable>(result: JSONResult, completion: @escaping (U?)->Void){
        switch result {
        case .success(let response):
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            guard let result = try? decoder.decode(U.self, from: response.data) else{
                completion(nil)
                return
            }
            completion(result)
        case .failure:
            completion(nil)
        }
    }
}
