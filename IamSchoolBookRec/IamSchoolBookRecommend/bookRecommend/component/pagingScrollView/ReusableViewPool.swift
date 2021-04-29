//
//  ReusableViewPool.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/27.
//

import UIKit

public class ReusableViewPool<T: AnyObject> {
    private var reuseViewPool: [T] = [T]()
    
    var count: Int {
        reuseViewPool.count
    }
    var first: T? {
        reuseViewPool.first
    }
    
    func removeFirst() -> T?{
        return reuseViewPool.removeFirst()
    }
    func removeAll() {
        reuseViewPool.removeAll()
    }
    func remove(element: T) {
        reuseViewPool.removeAll(where: {
            $0 === element
        })
    }
    
    func append(_ element: T) {
        reuseViewPool.append(element)
    }
    
    func forEach(_ body: (T) throws -> Void) {
        do {
            try reuseViewPool.forEach(body)
        }
        catch {
            print("for each failed")
        }
    }
    
}
protocol Indexable {
    var index: Int? { get }
}

// where 문 사용해서 T의 타입 지정 extension
extension ReusableViewPool {
    // Reusable 밖에서 해도 될것같다.
    // T.index (index 프로퍼티만 가진 프로토콜을)
    func hasElement(index: Int) -> Bool where T: Indexable {
        let indexElements = reuseViewPool.filter({ $0.index == index })
        return !indexElements.isEmpty
    }
    
    subscript(index: Int) -> T? where T: Indexable {
        return reuseViewPool.filter({ $0.index == index }).first
    }
}
