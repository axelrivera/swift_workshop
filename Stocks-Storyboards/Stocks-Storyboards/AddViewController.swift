//
//  AddViewController.swift
//  Stocks
//
//  Created by Axel Rivera on 9/21/14.
//  Copyright (c) 2014 Axel Rivera. All rights reserved.
//

import UIKit

class AddViewController: UITableViewController {

    struct Config {
        static let CellIdentifier = "Cell"
    }

    var textField: UITextField!

    var saveBlock: ((symbol: String?) -> ())?
    var cancelBlock: (() -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.keyboardDismissMode = .Interactive

        textField = UITextField(frame: CGRectMake(0.0, 0.0, 210.0, 30.0))
        textField.placeholder = "Enter Stock Symbol"
        textField.contentVerticalAlignment = .Center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Selector Methods

    @IBAction func saveAction(sender: AnyObject!) {
        self.view.endEditing(true)
        if let block = saveBlock {
            block(symbol: textField.text)
        }
    }

    @IBAction func cancelAction(sender: AnyObject!) {
        self.view.endEditing(true)
        if let block = cancelBlock {
            block()
        }
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(Config.CellIdentifier) as UITableViewCell!

        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: Config.CellIdentifier)
            cell.accessoryView = textField
        }

        cell.textLabel?.text = "Symbol"

        return cell
    }

}
