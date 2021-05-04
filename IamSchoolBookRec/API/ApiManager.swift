//
//  IamSchoolAPI.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/28.
//

import Foundation

public enum ApiError: Error {
    case serverRequestNotOk
    case jsonParseError
}

// TODO
// alamofire
// error -> retry? cancel?
public class ApiManager: NSObject {
    // task array
    private var session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    // append queue
    public func fetchData<T: Decodable>(request: URL, completion: @escaping (Result<[T]?, ApiError>) -> Void) -> URLSessionTask {
        let request = URLRequest(url: request)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            if error != nil {
                print("Error \(String(describing: error))")
            }
            
            guard let httpUrlResponse = response as? HTTPURLResponse else {
                print("HTTPURLResponse error")
                return
            }
            
            if httpUrlResponse.statusCode != 200 {
                completion(.failure(.serverRequestNotOk))
                return
            }
            
            if let result: Result<[T]?, ApiError> = self.processRequestData(data: data, error: error) {
                completion(result)
            }
        }
        return task
    }
    
    private func processRequestData<T: Decodable>(data: Data?, error: Error?) -> Result<[T]?, ApiError>? {
        guard let data = data else {
            return .failure(.jsonParseError)
        }
        // check
//        let dataAsString = String(data: data, encoding: .utf8)
//        print(dataAsString!)

        do {
            let requestJsonDatas = try JSONDecoder().decode([T].self, from: data)
            return .success(requestJsonDatas)
        } catch let jsonError {
            print(jsonError)
            return .failure(.jsonParseError)
        }
    }
}
