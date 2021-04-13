//
//  PhotoStore.swift
//  Photorama
//
//  Created by NHN on 2021/04/13.
//

// NSURLRequest의 프로퍼티를 살펴보자
// allHTTPHeaderFields - HTTP 트랜젝션에 관한 메타데이터의 딕셔너리
// allowsCellularAccess - 요청에서 셀룰러 데이터를 사용할 것인지 여부
// cachePolicy - 로컬 캐시를 어떻게 상요할지 결정
// HTTPMethod - 요청 메서드
// timeoutInterval - 서버에 요청을 시도할 연결의 최대 지속시간

// NSURLSession
// 웹서버와 통신하는 클래스는 URLSessionTask의 인스턴스
// 데이터 : 서버로 데이터를 가져와 Data 클래스로 반환
// 다운로드 : 데이터를 가져와 파일시스템에 파일로 저장
// 업로드 : 서버로 데이터를 보낸다.

import UIKit

enum ImageResult {
    case Success(UIImage)
    case Failure(Error)
}
enum PhotoError: Error {
    case ImageCreationError
}

class PhotoStore {
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    
    func fetchImageForPhoto(photo: Photo, completion: @escaping (ImageResult) -> Void) {
        let photoURL = photo.remoteURL
        let request = URLRequest(url: photoURL)
        
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            let result = self.processImageRequest(data: data, error: error)
            if case let .Success(image) = result {
                photo.image = image
            }
            completion(result)
        }
        task.resume()
    }
    
    func fetchRecentPhotos(completion: @escaping (PhotosResult) -> Void) {
        let url = FlickrAPI.recentPhotosURL()
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
//            if let jsonData = data {
////                if let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
////                    print(jsonString)
////                }
//                do {
//                    let jsonObject: Any = try JSONSerialization.jsonObject(with: jsonData, options: [])
//                    print("json object")
//                    print(jsonObject)
//                }
//                catch let error {
//                    print("error create JSON object \(error)")
//                }
//            }
//            else if let requestError = error {
//                print("error fetching recent photos: \(requestError)")
//            }
//            else {
//                print("unexprected error with the request")
//            }
            let result = self.processRecentPhotoRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    func processImageRequest(data: Data?, error: Error?) -> ImageResult {
        guard let imageData = data,
              let image = UIImage(data: imageData) else {
            if data == nil {
                return .Failure(error!)
            }
            else {
                return .Failure(PhotoError.ImageCreationError)
            }
        }
        return .Success(image)
    }
    
    func processRecentPhotoRequest(data: Data?, error: Error?) -> PhotosResult {
        guard let jsonData = data else {
            return .Failure(error!)
        }
        return FlickrAPI.photoFromJSONData(data: jsonData)
    }
    
    
}
