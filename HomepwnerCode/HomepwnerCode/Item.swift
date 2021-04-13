//
//  Item.swift
//  Homepwner
//
//  Created by NHN on 2021/04/09.
//

import UIKit

// NSCoder 구현
class Item: NSObject, NSCoding {
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    let dateCreated: NSDate
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as! String
        print(name)
        dateCreated = coder.decodeObject(forKey: "dateCreated") as! NSDate
        print(dateCreated)
        serialNumber = coder.decodeObject(forKey: "serialNumber") as! String?
        
        valueInDollars = coder.decodeInteger(forKey: "valueInDollars")
        super.init()
    }
    
    init(name: String, serialNumber: String?, valueInDollars: Int) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = NSDate()
    }
    
    convenience init(random: Bool = false) {
        if random {
            let adjectives = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork", "Mac"]
            
            var idx = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = adjectives[Int(idx)]
            
            idx = arc4random_uniform(UInt32(nouns.count))
            let randomNoun = nouns[Int(idx)]
            
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int(arc4random_uniform(100))
            let randomSerialNumber = NSUUID().uuidString.components(separatedBy: "-").first!
            
            self.init(name: randomName,
                      serialNumber: randomSerialNumber,
                      valueInDollars: randomValue)
            
        }
        else {
            self.init(name: "", serialNumber: nil, valueInDollars: 0)
        }
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(dateCreated, forKey: "dateCreated")
        coder.encode(serialNumber, forKey: "serialNumber")
        
        coder.encode(valueInDollars, forKey: "valueInDollars")
    }
    
    var section: Int {
        get {
            if self.valueInDollars >= 50 {
                return 1
            }
            else {
                return 0
            }
        }
    }
}
