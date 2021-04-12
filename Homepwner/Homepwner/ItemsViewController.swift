import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    @IBAction func addNewItem(sender: AnyObject) {
        let _ = self.itemStore.createItem()
        tableView.reloadData()
    }
    
    @IBAction func toggleEditingMode(sender: AnyObject) {
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
        
        self.itemStore = ItemStore()
        // 동적 height를 설정, rowHeigh의 기본값 automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        // 스크롤이 일어날 때까지 미룰 수 있다.
        tableView.estimatedRowHeight = 65
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // 테이블뷰의 총 섹션 개수를 묻는 메서드
    override func numberOfSections(in: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        guard section != 2 else {
            return 1
        }
        
        return self.itemStore[section]?.count ?? 0
    }
    
    // 셀을 만들고, 그 셀의 내용을 설정
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //물품 배열의 indexPath, n 번째에 있는 항목의 설명을 n과 row와 일치하는 셀의 텍스트로 설정
        guard let item = self.itemStore[indexPath] else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noMoreItemCell", for: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        // 재사용 셀을 얻거나, 새로운 셀을 얻는다.
        cell.updateLabels(item: item)
        
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "\(item.valueInDollars)"
        
        return cell
    }

    // 테이블 삭제는 승인을 위해 호출한다.
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        // 테이블 뷰가 삭제 명령의 적용을 요청하면
        if editingStyle == .delete {
            guard let item = itemStore[indexPath] else {
                return
            }
            
            
            let title = "Delete \(item.name)?"
            let message = "정말로 삭제하시겠습니까?"
            print(title, message)
            
            let ac = UIAlertController(title: title,
                                       message: message,
                                       preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            // 삭제 시 옵션을 핸들러로 클로저로 만들어 전달한다.
            let deleteAction = UIAlertAction(title: "Remove", style: .destructive, handler: { (action) -> Void in
                // 저장소에서 그 항목을 제거한다.
                self.itemStore.removeItem(item: item)
                
                tableView.reloadData()
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
    
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if sourceIndexPath.section == 2 {
            return IndexPath(row: 0, section: 2)
        }
        else if proposedDestinationIndexPath.section == 2 {
            return sourceIndexPath
        }
        else {
            return proposedDestinationIndexPath
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let uiStoryboardSegue = UIStoryboardSegue(identifier: "ShowItem", source: self, destination: DetailViewController())
        prepare(for: uiStoryboardSegue, sender: tableView.cellForRow(at: indexPath))
    }
    
    // show segue를 위한 메서드
    // UIStoryboardSegue는 세 가지 정보를 가진다.
    // 뷰 컨트롤러(세그웨이가 시작된 곳)와, 목표 뷰 컨트롤러(세그웨이가 끝난 곳), 세그웨이 식별자로 구분할 수 있다.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowItem" {
            // 어느 행이 눌렀는지,
            if let indexPath = tableView.indexPathForSelectedRow{
                print(indexPath)
                guard let item = itemStore[indexPath] else {
                    return
                }
                
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
            }
        }
    }
    
}
