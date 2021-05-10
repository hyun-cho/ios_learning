//
//  BookRecommendAPI.swift
//  BookRecommendData
//
//  Created by NHN on 2021/04/30.
//

import Foundation
import API

public class BookRecommendAPI {
    
    private let apiManager: ApiManagerAlamofire = ApiManagerAlamofire()
    private let baseURLString = "http://nany.synology.me/book-home.json"
    private var tasks: [String] = []
    
    
    public init() {}
    private func bookRecommendURL() -> URL? {
        let components = URLComponents(string: baseURLString)
        return components?.url
    }
    
    public func fetchDataFromServer(completion: @escaping (Result<[BookRecommendResponseDto], BookRecommendApiError>) -> Void) {
        guard let url = bookRecommendURL() else {
            print("book recommend baseURL is not created")
            return
        }
        
        let completionClosure: (_ result: Result<[BookRecommendResponseDto], ApiError>) -> Void = {
            (result: Result<[BookRecommendResponseDto], ApiError>) -> Void in
            switch result {
            case .success(let jsonData):
                completion(.success(jsonData))
            case .failure(let error):
                switch error {
                case .serverRequestNotOk:
                    print("please check the server")
                case .jsonParseError:
                    print("json parse error")
                case .unexpectedError:
                    print("unexpected error")
                }
                completion(.failure(.recallApi))
            }
        }
        self.tasks.append(apiManager.fetchData(request: url, completion: completionClosure))
    }
    
    public func cancel() {
        guard let task = tasks.first else {
            print("book recommend baseURL is not created")
            return
        }
        apiManager.cancel(id: task)
        tasks.removeFirst()
    }
}
