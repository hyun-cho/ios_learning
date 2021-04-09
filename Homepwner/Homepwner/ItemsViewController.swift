//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by NHN on 2021/04/09.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    // SceneDelegate에서 데이터소스를 주입받았다.
    var itemStore: ItemStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // iOS 13부터 deprecated된 사항
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
//        // window scene을 사용하는 방법 -> view.window == nil??? (검색해보니 view 생명주기에 대해서 공부해야 할 것 같습니다...)
//        // scene으로 바뀌면서, 스테이터스 바를 해치지 않는 것 같습니다.
//        let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
        
//        // UIApplication으로 window에 접근하는 방법,
//        let _ = UIApplication.shared.windows.first!.rootViewController
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        // tabView와 view는 같은 인스턴스 이지만, Type을 UITableView로 컴파일 단계에서 받을 수 있다.
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    // 셀을 만들고, 그 셀의 textLabel을 해당 Item의 name으로 설정하고, detailTextLabel은 Item의 valueInDollars로 설정
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 기본 모양을 가진 UITableViewCell 인스턴스 생성
        // reuseIdentifier : 각 셀은 이 프로퍼티를 가지고 있어, 테이블 뷰에 재사용 셀을 요청할 때 문자열을 전달하고, 이 재샤용 식별자를 지닌 셀이 필요하다고 전달한다.
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        
        // 재사용 셀을 얻거나, 새로운 셀을 얻는다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        //물품 배열의 indexPath, n 번째에 있는 항목의 설명을 n과 row와 일치하는 셀의 텍스트로 설정
        let item = itemStore.allItems[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
    
        
        return cell
    }
}
