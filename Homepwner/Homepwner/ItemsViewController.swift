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
    
    @IBAction func addNewItem(sender: AnyObject) {
//        // 0번 섹션, 마지막 행의 인덱스 패스를 만든다.
//        let lastRow = tableView.numberOfRows(inSection: 0)
//        let indexPath = IndexPath(row: lastRow, section: 0)
//
////        tableView.insertRows(at: <#T##[IndexPath]#>, with: <#T##UITableView.RowAnimation#>)
//        // ItemStore에 값을 넣지 않으면, tableView 에서의 개수와 불일치가 일어나 오류가 나온다.
//
//        tableView.insertRows(at: [indexPath], with: .automatic)
        
        let newItem = itemStore.createItem()
        
        if let index = itemStore.allItems.firstIndex(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            
            // 테이블에 새로운 행을 삽입한다.
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    @IBAction func toggleEditingMode(sender: AnyObject) {
        // 편집 모드인지
        if isEditing {
            // 사용자에게 상태를 알리기 위해 버튼의 텍스트를 변경한다.
            sender.setTitle("Edit", for: UIControl.State.normal)
            
            // 편집 모드를 끈다.
            setEditing(false, animated: true)
        }
        else {
            // 사용자에게 상태를 알리기 위해 버튼의 텍스트를 변경한다.
            sender.setTitle("Done", for: UIControl.State.normal)
            
            // 편집 모드로 들어간다.
            setEditing(true, animated: true)
        }
    }
    
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

    // 테이블 삭제는 승인을 위해 호출한다.
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        // 테이블 뷰가 삭제 명령의 적용을 요청하면
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Delete \(item.name)?"
            let message = "정말로 삭제하시겠습니까?"
            print(title, message)
            
            let ac = UIAlertController(title: title,
                                       message: message,
                                       preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            // 삭제 시 옵션을 핸들러로 클로저로 만들어 전달한다.
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
                // 저장소에서 그 항목을 제거한다.
                self.itemStore.removeItem(item: item)
                
                // 또한 애니메이션과 함께 테이블 뷰에서 그 행을 제거한다.
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            
            // 등록한 뷰 컨트롤러를 화면에 노출한다.
            present(ac, animated: true, completion: nil)
        }
    }
    
    // 테이블 이동은, 별도의 승인절차가 필요하지 않아 테이블이 직접 실행한다.
    // 하지만, itemStore의 위치를 변환해야한다.
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        itemStore.moveItemAtIndex(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    
}
