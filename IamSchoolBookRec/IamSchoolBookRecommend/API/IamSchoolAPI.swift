//
//  IamSchoolAPI.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/28.
//

import Foundation

enum ApiResult<T> {
    case Success([T])
    case Failure(ApiError)
}
enum ApiError: Error {
    case serverRequestNotOk
    case jsonParseError
}

// 기능구현 -> generic 가능하게 구현
struct IamSchoolAPI {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchData<T: Decodable>(request: URL, completion: @escaping ([T]?) -> Void){
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
                return
            }
            
            if let result: ApiResult<T> = self.processRequestData(data: data, error: error) {
                switch result {
                case .Success(let jsonData):
                    completion(jsonData)
                case .Failure(let error):
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    private func processRequestData<T: Decodable>(data: Data?, error: Error?) -> ApiResult<T>? {
        guard let data = data else {
            return .Failure(.jsonParseError)
        }
        
        // check
        let dataAsString = String(data: data, encoding: .utf8)
        print(dataAsString!)

        do {
            let requestJsonDatas = try JSONDecoder().decode([T].self, from: data)
            return .Success(requestJsonDatas)
        } catch let jsonError {
            print(jsonError)
            return .Failure(.jsonParseError)
        }
    }
}

