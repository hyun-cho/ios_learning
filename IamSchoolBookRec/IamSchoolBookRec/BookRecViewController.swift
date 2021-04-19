//
//  BookRecViewController.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/15.
//

import UIKit

class BookRecViewController: UITableViewController {
    var bookStore: BookStore?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookStore = BookStore()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        
        navigationController?.navigationItem.backBarButtonItem?.tintColor = .black
        tableView.reloadData()
    }
}

// dataSource
extension BookRecViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
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
        // Fetch a cell of the appropriate type.
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookRecFirstCell", for: indexPath) as! BookRecFirstCell
            
            // Configure the cell’s contents
            cell.initBooks(bookStore: self.bookStore!)
            return cell
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookRecSecondCell", for: indexPath)
            return cell
        }
        else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookRecThirdCell", for: indexPath) as! BookRecThirdCell
            cell.initBooks(title: "책 목록", bookStore: self.bookStore!)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookRecFourthCell", for: indexPath) as! BookRecFourthCell
            print(cell)
            cell.initBookGuide(bookGuide: BookGuide(title: "국어 실력 UP! ~~~~~", description: "국어 실력과 독서 습관을 ~~~~~~~~~~", remoteURL: "https://charlottesometimesgoestothemovies.files.wordpress.com/2020/03/books.jpg?w=1024&h=717&crop=1"))
            return cell
        }
    }
    
}

//delegate
extension BookRecViewController {
    // rowHeight가 자동으로 안늘어난다 왜??
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 280
        }
        return UITableView.automaticDimension
    }
    
}
