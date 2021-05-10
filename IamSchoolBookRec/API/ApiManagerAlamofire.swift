
//
//  apiManagerAlamofire.swift
//  API
//
//  Created by NHN on 2021/05/04.
//

import Foundation
import Alamofire

// alamofire
public class ApiManagerAlamofire: NSObject, ApiManager {
    private var requestDictionary: [String: Request] = [:]
    public func fetchData<T>(request: URL, completion: @escaping (Result<[T], ApiError>) -> Void) -> String where T : Decodable {
        let alamo = AF.request(request, method: .get).validate(statusCode: [200])
        alamo.responseJSON(completionHandler: {
            [weak self]
            response in
            switch response.result {
            case .success(let value):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    if let result: Result<[T], ApiError> = self?.processRequestData(data: jsonData) {
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
        requestDictionary[alamo.id.uuidString] = alamo
        return alamo.id.uuidString
    }
    
    
    public func downloadData(request: String) -> String {
//        let request = "https://rss.art19.com/episodes/ac7129bf-8052-4ee7-a21c-0314e6620e3c.mp3"
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .userDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("ac7129bf-8052-4ee7-a21c-0314e6620e3c.mp3")

            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }

        let alamo = AF.download(request, to: destination).response {
            response in
            
            if response.error == nil,
               let mp3Path = response.fileURL?.path {
                print(mp3Path)
            }
        }
        requestDictionary[alamo.id.uuidString] = alamo
        return alamo.id.uuidString
    }
    
    // id
    public func cancel(id: String) {
        guard let request = requestDictionary[id] else {
            return
        }
        if !request.isCancelled {
            request.cancel()
        }
    }
    
    public func pauseDownload(id: String) {
        guard let request = requestDictionary[id] as? DownloadRequest else {
            return
        }
        request.suspend()
    }
    
    public func resumeDownload(id: String) {
        guard let request = requestDictionary[id] as? DownloadRequest else {
            return
        }
        request.resume()
    }
}
