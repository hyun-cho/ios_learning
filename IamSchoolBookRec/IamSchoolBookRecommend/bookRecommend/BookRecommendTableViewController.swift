//
//  BookRecViewController.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/15.
//

import UIKit

class BookRecommendTableViewController: UITableViewController {
    fileprivate(set) var serverDataSource: ServerDataSourceStore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 데이터를 가져오는 부분, 추가 구현 예정
        serverDataSource = ServerDataSourceStore()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        
        navigationController?.navigationItem.backBarButtonItem?.tintColor = .black
        tableView.reloadData()
    }
}

// dataSource
extension BookRecommendTableViewController {
    // Return the number of rows for the table.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serverDataSource?.serverData.count ?? 0
    }

    // Provide a cell object for each row.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let bookRecommendationCellData = serverDataSource?[indexPath] else {
            return UITableViewCell()
        }
        switch bookRecommendationCellData {
        case .standSlidingData(let standSlidingCellData):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: standSlidingCellData.cellIdentifier, for: indexPath) as? StandSlidingCell else {
                return UITableViewCell()
            }
            cell.viewModel = standSlidingCellData
            return cell
        case .buttonNavigationData(let buttonNavigationData):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: buttonNavigationData.cellIdentifier, for: indexPath) as? ButtonNavigationCell else {
                return UITableViewCell()
            }
            cell.viewModel = buttonNavigationData
            return cell
        case .bookCollectionTypeAData(let bookCollectionTypeAData):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: bookCollectionTypeAData.cellIdentifier, for: indexPath) as? BookCollectionTypeACell else {
                return UITableViewCell()
            }
            cell.viewModel = bookCollectionTypeAData
            return cell
        case .bookGuideData(let bookGuideData):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: bookGuideData.cellIdentifier, for: indexPath) as? BookGuideCell else {
                return UITableViewCell()
            }
            cell.viewModel = bookGuideData
            return cell
        case .bookScrapData(let bookScrapData):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: bookScrapData.cellIdentifier, for: indexPath) as? BookScrapCell else {
                return UITableViewCell()
            }
            cell.viewModel = bookScrapData
            return cell
        case .bookScrollData(let bookScrollData):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: bookScrollData.cellIdentifier, for: indexPath) as? BookScrollCell else {
                return UITableViewCell()
            }
            cell.viewModel = bookScrollData
            return cell
        case .none:
            return UITableViewCell()
        }
    }
    
}

//delegate
extension BookRecommendTableViewController {
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
}
