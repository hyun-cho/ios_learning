//
//  ApiManagerURLSession.swift
//  API
//
//  Created by NHN on 2021/05/04.
//

import Foundation

public class ApiManagerURLSession: NSObject, ApiManager {
    // task array
    private var session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    // append queue
    public func fetchData<T: Decodable>(request: URL, completion: @escaping (Result<[T]?, ApiError>) -> Void) -> URLSessionTask? {
        let request = URLRequest(url: request)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            if error != nil {
                print("Error \(String(describing: error))")
                completion(Result.failure(.unexpectedError))
            }
            
            guard let httpUrlResponse = response as? HTTPURLResponse else {
                print("HTTPURLResponse error")
                return
            }
            
            if httpUrlResponse.statusCode != 200 {
                completion(.failure(.serverRequestNotOk))
                return
            }
            
            if let result: Result<[T]?, ApiError> = self.processRequestData(data: data) {
                completion(result)
            }
        }
        return task
    }
}
