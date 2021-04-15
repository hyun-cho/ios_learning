//
//  BookRecViewController.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/15.
//

import UIKit

class BookRecViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// dataSource
extension BookRecViewController {
    // Return the number of rows for the table.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 0
    }

    // Provide a cell object for each row.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fetch a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookFirstIntroPageCell", for: indexPath) as! BookFirstIntroPageCell
       
        // Configure the cell’s contents.
        cell.bookNameLabel.text = "Book name"
        cell.bookDescLabel.text = "Book description"
           
        return cell
    }
}

extension BookRecViewController {
    
}
