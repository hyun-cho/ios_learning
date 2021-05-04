//
//  BookRecommendAPI.swift
//  BookRecommendData
//
//  Created by NHN on 2021/04/30.
//

import Foundation
import API

public class BookRecommendAPI {
    public init() {
        
    }
    private let apiManager: ApiManager = ApiManagerURLSession()
    private let baseURLString = "http://nany.synology.me/book-home.json"
    
    private func bookRecommendURL() -> URL? {
        let components = URLComponents(string: baseURLString)
        return components?.url
    }
    private var task: URLSessionTask?
    // API (retry or cancel) -> compile or download... 도중
    public func fetchDataFromServer(completion: @escaping ([BookRecommendResponseDto]?) -> Void) -> Void {
        guard let url = bookRecommendURL() else {
            print("book recommend baseURL is not created")
            return
        }
        
        let completionClosure: (_ result: Result<[BookRecommendResponseDto]?, ApiError>) -> Void = {
            [weak self]
            (result: Result<[BookRecommendResponseDto]?, ApiError>) -> Void in
            switch result {
            case .success(let jsonData):
                completion(jsonData)
            case .failure(let error):
                switch error {
                case .serverRequestNotOk:
                    print("please check the server")
                case .jsonParseError:
                    print("json parse error")
                case .unexpectedError:
                    completion(nil)
                    self?.task?.cancel()
                }
            }
        }
        task = apiManager.fetchData(request: url, completion: completionClosure)
        task?.resume()
    }
    public func cancel() {
        task?.cancel()
    }
}
