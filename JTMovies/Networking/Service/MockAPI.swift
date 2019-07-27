//
//  Router.swift
//  JTMovies
//
//  Created by Jeff Tabios on 24/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation
import Networking

class MockAPI:APIProtocol{
    private var data:Data?
    func request<U:Codable>(endPoint: EndPoint, completion: @escaping (U?)->Void){
        
        let jsonFile = "mock" +  endPoint.path.replacingOccurrences(of: "/", with: "-")
        if let path = Bundle.main.path(forResource: jsonFile, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                decode(completion: completion)
            } catch {
                completion(nil)
            }
        }else{
            fatalError(jsonFile + ".json not found")
        }
    }
    
    func decode<U:Decodable>(completion: @escaping (U?)->Void){
        if let data = data {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            guard let result = try? decoder.decode(U.self, from: data) else{
                completion(nil)
                return
            }
            completion(result)
        }else{
            completion(nil)
        }
    }
}
