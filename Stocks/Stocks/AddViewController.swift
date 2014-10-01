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

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override required init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "Add Stock"
    }

    override func loadView() {
        self.tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: .Grouped)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.keyboardDismissMode = .Interactive

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .Cancel,
            target: self,
            action: "cancelAction:"
        )

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .Save,
            target: self,
            action: "saveAction:"
        )

        textField = UITextField(frame: CGRectMake(0.0, 0.0, 210.0, 30.0))
        textField.placeholder = "Enter Stock Symbol"
        textField.contentVerticalAlignment = .Center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Selector Methods

    func saveAction(sender: AnyObject!) {
        self.view.endEditing(true)
        if let block = saveBlock {
            block(symbol: textField.text)
        }
    }

    func cancelAction(sender: AnyObject!) {
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
