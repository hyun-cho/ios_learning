//
//  ItemStore.swift
//  Homepwner
//
//  Created by NHN on 2021/04/09.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    func getIndexPath(item: Item) -> IndexPath? {
        guard let items = self[item.section] else {
            return nil
        }
        guard let index = items.firstIndex(of: item) else {
            return nil
        }
        
        return IndexPath(row: index, section: item.section)
    }
    
    init() {
        for _ in 0..<5 {
            let _ = createItem()
        }
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
