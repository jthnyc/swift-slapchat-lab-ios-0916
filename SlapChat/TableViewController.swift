//
//  TableViewController.swift
//  SlapChat
//
//  Created by Ian Rahman on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var store = DataStore.sharedInstance
    

    override func viewDidLoad() {
        super.viewDidLoad()
        store.fetchData()
        
        // when having made changes to the view, need to reload the data to refresh it
        tableView.reloadData()
        
  //      store.doomsdayDelete()
    
    }
    
    // viewWillAppear appears multiple times (as opposed to viewDidLoad)
    override func viewWillAppear(_ animated: Bool) {
        store.fetchData()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        
        cell.textLabel?.text = store.messages[indexPath.row].content
        
        return cell
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.messages.count
    }
    
   
}
