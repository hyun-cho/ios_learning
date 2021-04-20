//
//  BookRecViewController.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/15.
//

import UIKit

class BookRecommendTableViewController: UITableViewController {
    var tasks: CellDataSourceStore?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 데이터를 가져오는 부분, 추가 구현 예정
        tasks = CellDataSourceStore()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        
        navigationController?.navigationItem.backBarButtonItem?.tintColor = .black
        tableView.reloadData()
    }
}

// dataSource
extension BookRecommendTableViewController {
    // section, row? -> section이 필요가 없을것같다.!! TODO
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tasks?.tasks.count ?? 0
    }
    
    // Return the number of rows for the table.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section <= 3 {
            return 1
        }
        return 0
    }

    // Provide a cell object for each row.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // section과 정보를 같이 서버에서 전해준다. (type - section / data)
        // Fetch a cell of the appropriate type.
        // 배열 index check<<
//        guard let task = tasks?[indexPath.row] as! BookRecommendationCellData else {
//            return UITableViewCell()
//        }
//        switch task {
//        case .StandSlidingCellData(let standSlidingCellData):
//            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? StandSlidingCell
//            cell.
//        }
        
        guard let task = tasks?[indexPath.section],
           let identifier = task.cellIdentifier?.rawValue,
           let cellWithTask = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? HasTask else {
            print("cell does not cast to HasTask")
            return UITableViewCell()
        }
        // task -> 타입 캐스팅 -> 
        cellWithTask.updateTask(task: task)
        guard let cell = cellWithTask as? UITableViewCell else {
            print("cell does not cast to HasTask")
            return UITableViewCell()
        }
        return cell
    }
    
}

//delegate
extension BookRecommendTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
