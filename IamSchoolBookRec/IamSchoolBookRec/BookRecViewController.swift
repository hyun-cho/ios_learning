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
    }
}

// dataSource
extension BookRecViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Return the number of rows for the table.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section <= 1 {
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
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookRecSecondCell", for: indexPath)
            return cell
        }
    }
    
}

//delegate
extension BookRecViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
