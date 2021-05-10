//
//  BookRecViewController.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/15.
//
//  MVI

import UIKit

class BookRecommendTableViewController: UITableViewController {
    private var serverDataSource: ServerDataSource = ServerDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serverDataSource.fetchCellDatas {
            [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        
        navigationController?.navigationItem.backBarButtonItem?.tintColor = .black
    }
}

// dataSource
extension BookRecommendTableViewController {
    // Return the number of rows for the table.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serverDataSource.cellDataCount
    }

    // Provide a cell object for each row.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let bookRecommendationCellData = serverDataSource[indexPath] else {
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
        case .bookCollectionData(let bookCollectionData):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: bookCollectionData.cellIdentifier, for: indexPath) as? BookCollectionCell else {
                return UITableViewCell()
            }
            cell.viewModel = bookCollectionData
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
        case .bookTagCollectionData(let bookTagCollesctionData):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: bookTagCollesctionData.cellIdentifier, for: indexPath) as? BookTagCollectionCell else {
                return UITableViewCell()
            }
            cell.viewModel = bookTagCollesctionData
            return cell
        case .none:
            return UITableViewCell()
        }
    }
    
}
