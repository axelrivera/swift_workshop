//
//  DetailViewController.swift
//  Stocks
//
//  Created by Axel Rivera on 9/21/14.
//  Copyright (c) 2014 Axel Rivera. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    struct Config {
        static let CellIdentifier = "Cell"
    }

    var tableView: UITableView!
    var dataSource: [[String: String?]] = []

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(ticker: Ticker) {
        super.init(nibName: nil, bundle: nil)
        self.title = ticker.symbol
        self.dataSource = ticker.toArray()
    }

    override func loadView() {
        self.view = UIView(frame: UIScreen.mainScreen().bounds)
        self.view.backgroundColor = UIColor.whiteColor()

        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.dataSource = self
        tableView.delegate = self

        self.view.addSubview(tableView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false

        // AutoLayout
        tableView.autoPinToTopLayoutGuideOfViewController(self, withInset: 0.0)
        tableView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero, excludingEdge: .Top)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDataSource Methods

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(Config.CellIdentifier) as UITableViewCell!

        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: Config.CellIdentifier)
        }

        let dictionary = dataSource[indexPath.row]

        cell.textLabel?.text = dictionary["label"]!
        cell.detailTextLabel?.text = dictionary["value"]!

        cell.accessoryType = .None
        cell.selectionStyle = .None

        return cell
    }

    // MARK: - UITableViewDelegate Methods

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Basic Information"
    }

}
