//
//  IamSchoolAPI.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/28.
//

import Foundation

public protocol ApiManager: NSObjectProtocol {
    func fetchData<T: Decodable>(request: URL, completion: @escaping (Result<[T]?, ApiError>) -> Void) -> URLSessionTask?
}

extension ApiManager {
    func processRequestData<T: Decodable>(data: Data?) -> Result<[T]?, ApiError>? {
        guard let data = data else {
            return .failure(.jsonParseError)
        }
        
        do {
            let requestJsonDatas = try JSONDecoder().decode([T].self, from: data)
            return .success(requestJsonDatas)
        } catch let jsonError {
            print(jsonError)
            return .failure(.jsonParseError)
        }
    }
}
