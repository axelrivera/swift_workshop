//
//  DetailViewController.swift
//  Stocks
//
//  Created by Axel Rivera on 9/21/14.
//  Copyright (c) 2014 Axel Rivera. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    struct Config {
        static let CellIdentifier = "Cell"
    }

    var dataSource: [[String: String?]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDataSource Methods

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Config.CellIdentifier, forIndexPath: indexPath) as UITableViewCell

        let dictionary = dataSource[indexPath.row]

        cell.textLabel?.text = dictionary["label"]!
        cell.detailTextLabel?.text = dictionary["value"]!

        cell.accessoryType = .None
        cell.selectionStyle = .None

        return cell
    }

    // MARK: - UITableViewDelegate Methods

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Basic Information"
    }

}
