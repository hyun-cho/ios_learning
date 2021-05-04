
//
//  apiManagerAlamofire.swift
//  API
//
//  Created by NHN on 2021/05/04.
//

import Foundation
import Alamofire

class ApiManagerAlamofire: NSObject, ApiManager {
    func fetchData<T>(request: URL, completion: @escaping (Result<[T]?, ApiError>) -> Void) -> URLSessionTask? where T : Decodable {
        let alamo = AF.request(request, method: .get).validate(statusCode: [200])
        alamo.responseJSON(completionHandler: {
            response in
            switch response.result {
            case .success(let value):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    if let result: Result<[T]?, ApiError> = self.processRequestData(data: jsonData) {
                        completion(result)
                    }
                } catch {
                    print("error")
                }
            case .failure(let error):
                print("error: \(String(describing: error.errorDescription))")
                completion(.failure(.serverRequestNotOk))
            }
        })
        return alamo.task
//        return nil
    }
}
