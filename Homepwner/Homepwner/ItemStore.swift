//
//  ItemStore.swift
//  Homepwner
//
//  Created by NHN on 2021/04/09.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    
    init() {
        //'unarchiveObject(withFile:)' was deprecated in iOS 12.0: Use +unarchivedObjectOfClass:fromData:error: instead
//        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Item] {
//            allItems += archivedItems
//        }
        print("itemStore init start")
        do {
            let data = try Data(contentsOf: itemArchiveURL)
            print("data loaded \(data)")
            if let loadedItems = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Item] {
                print("loadedItem \(loadedItems)")
                allItems = loadedItems
            }
        } catch {
            print("itemStore data load failed")
        }
    }
    
    let itemArchiveURL: URL = {
        // 주어진 인자에 따라 기준에 부합하는 URL을 파일시스템에서 검색한다.
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent("items.archive")
    }()
    
    func saveChanges() -> Bool {
        print("Saving items to: \(itemArchiveURL.path)")
        //'archiveRootObject(_:toFile:)' was deprecated in iOS 12.0: Use +archivedDataWithRootObject:requiringSecureCoding:error: and -writeToURL:options:error: instead
//        return NSKeyedArchiver.archiveRootObject(allItems, toFile: "itemArchiveURL.path!")
        do {
            // NSKeyedArchiver 인스턴스를 만든다
            // allItems에서 encode를 호출한다.
            // allItems의 모든 객체에 동인한 NSKeyedArchiver를 전달해, encoding한다.
            // 수집한 데이터를 path에 쓴다.
            let data = try NSKeyedArchiver.archivedData(withRootObject: allItems, requiringSecureCoding: false)
            try data.write(to: itemArchiveURL)
            return true
        } catch {
            print("saveChanged failed")
            return false
        }
    }
    
    func getIndexPath(item: Item) -> IndexPath? {
        guard let items = self[item.section] else {
            return nil
        }
        guard let index = items.firstIndex(of: item) else {
            return nil
        }
        
        return IndexPath(row: index, section: item.section)
    }
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    func removeItem(item: Item) {
        if let index = allItems.firstIndex(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // 다시 삽입할 수 있도록, 이동 객체의 레퍼런스를 얻는다.
        let movedItem = allItems[fromIndex]
        
        allItems.remove(at: fromIndex)
        
        allItems.insert(movedItem, at: toIndex)
    }
    
    subscript(indexPath: IndexPath) -> Item? {
        guard let items = self[indexPath.section] else {
            return nil
        }
        
        guard items.count > indexPath.row else {
            return nil
        }
        
        return items[indexPath.row]
    }
    
    subscript(section: Int) -> [Item]? {
        if section == 0 {
            return allItems.filter({ $0.valueInDollars >= 50 })
        }
        else if section == 1 {
            return allItems.filter({ $0.valueInDollars < 50 })
        }
        else {
            return nil
        }
    }
}
