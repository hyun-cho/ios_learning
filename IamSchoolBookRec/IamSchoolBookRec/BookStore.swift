//
//  BookStore.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/16.
//

import UIKit

class BookStore {
    var books: [Book] = [Book]()
    
    init() {
        for i in 0..<5 {
            let _ = createItem(i)
        }
    }
    
    func createItem(_ i : Int) {
        let book = Book(name: "이유가 있어서 멸종 했습니다. \(i)", description: "세상에서 가장 재미있는 명종 동물 도감 \(i)", remoteURL: "https://images-na.ssl-images-amazon.com/images/I/41Q3VqCFCkL._SX322_BO1,204,203,200_.jpg")
        let url = URL(string: book.remoteURL)
        do {
            let data = try Data(contentsOf: url!)
            book.image = UIImage(data: data)
            books.append(book)
        } catch {
            print("book image load error")
        }
    }
}
