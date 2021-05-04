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
    private let apiManager: ApiManager = ApiManager()
    private let baseURLString = "http://nany.synology.me/book-home.json"
    
    private func bookRecommendURL() -> URL? {
        let components = URLComponents(string: baseURLString)
        return components?.url
    }
    
    // API (retry or cancel) -> compile or download... 도중
    public func fetchDataFromServer(completion: @escaping ([BookRecommendResponseDto]?) -> Void) -> Void {
        guard let url = bookRecommendURL() else {
            print("book recommend baseURL is not created")
            return
        }
        
        let task = apiManager.fetchData(request: url, completion: {
            (result: Result<[BookRecommendResponseDto]?, ApiError>) -> Void in
            switch result {
            case .success(let jsonData):
                completion(jsonData)
            case .failure(let error):
                print(String(describing: error))
            }
        })
        task.resume()
    }
}
