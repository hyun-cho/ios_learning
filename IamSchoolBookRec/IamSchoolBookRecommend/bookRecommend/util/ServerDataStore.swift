//
//  ServerDataStore.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/21.
//

import UIKit

struct ServerRawData {
    private(set) var cellType: String
    private(set) var data: String
}

class ServerDataStore {
    func getDataFromServer() -> [ServerRawData] {
        return [
//            ServerRawData(cellType: "standSliding", data: ""),
//            ServerRawData(cellType: "buttonNavigation", data: ""),
//            ServerRawData(cellType: "collectionTypeA", data: ""),
//            ServerRawData(cellType: "bookGuide", data: ""),
            ServerRawData(cellType: "bookScrap", data: ""),
            ServerRawData(cellType: "bookScrollTypeB", data: ""),
//            ServerRawData(cellType: "bookScrollTypeC", data: ""),
            ServerRawData(cellType: "this Is not for cell Type -> needs passing", data: "")
        ]
    }

}
