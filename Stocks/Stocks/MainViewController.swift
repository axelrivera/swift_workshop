//
//  MainViewController.swift
//  Stocks
//
//  Created by Axel Rivera on 9/20/14.
//  Copyright (c) 2014 Axel Rivera. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    struct Config {
        static let CellIdentifier = "Cell"
    }

    var symbols: [String] = [ "AAPL", "GOOG", "TWTR", "FB" ]
    var tickers: [Ticker] = []
    var shouldReload: Bool = false

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override required init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "Stocks"
    }

    override func loadView() {
        self.tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: .Plain)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        shouldReload = true

        self.refreshControl = UIRefreshControl(frame: CGRectZero)
        self.refreshControl?.addTarget(self, action: "reloadTickers:", forControlEvents: .ValueChanged)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .Add,
            target: self,
            action: "addSymbolAction:")

        self.tableView.rowHeight = TickerCell.defaultHeight
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        if shouldReload {
            self.reloadTickers(nil)
            shouldReload = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Selector Methods

    func reloadTickers(sender: AnyObject!) {
        self.navigationItem.rightBarButtonItem?.enabled = false

        StocksAPIClient.sharedClient.quoteForSymbols(symbols, completion: { [weak self] (tickers, error) in
            if let weakSelf = self {
                weakSelf.navigationItem.rightBarButtonItem?.enabled = true

                if weakSelf.refreshControl?.refreshing == true {
                    weakSelf.refreshControl?.endRefreshing()
                }

                if let myError = error {
                    UIAlertView(
                        title: "Stocks",
                        message: "Unable to load symbols!",
                        delegate: nil,
                        cancelButtonTitle: "OK"
                    ).show()

                    return
                }

                weakSelf.tickers = tickers

                //weakSelf.tableView.reloadData()

                weakSelf.tableView.beginUpdates()

                weakSelf.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)

                weakSelf.tableView.endUpdates()
            }
        })
    }

    func addSymbolAction(sender: AnyObject!) {
        var addController = AddViewController()

        addController.saveBlock = { [weak self] (symbol) in
            if let weakSelf = self {
                var symbolStr = ""
                if let tmp = symbol {
                    symbolStr = tmp
                }

                symbolStr = symbolStr.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())

                if symbolStr.isEmpty {
                    UIAlertView(
                        title: "Stocks",
                        message: "Enter a symbol!",
                        delegate: nil,
                        cancelButtonTitle: "OK"
                    ).show()
                    return
                }

                weakSelf.symbols.append(symbolStr)
                weakSelf.reloadTickers(nil)

                weakSelf.navigationController?.dismissViewControllerAnimated(true, completion: nil)
            }
        }

        addController.cancelBlock = { [weak self] in
            if let weakSelf = self {
                weakSelf.navigationController?.dismissViewControllerAnimated(true, completion: nil)
            }
        }

        let navController = UINavigationController(rootViewController: addController)
        self.navigationController?.presentViewController(navController, animated: true, completion: nil)
    }

    // MARK: - UITableViewDataSource Delegate Methods

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickers.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(Config.CellIdentifier) as TickerCell!
        if cell == nil {
            cell = TickerCell(reuseIdentifier: Config.CellIdentifier)
        }

        let ticker = tickers[indexPath.row]

        cell.symbolLabel.text = ticker.symbol
        cell.nameLabel.text = ticker.name
        cell.priceLabel.text = ticker.formattedClose
        cell.supportLabel.text = ticker.priceAndPercentChange
        cell.supportLabel.textColor = ticker.changeColor

        cell.selectionStyle = .Default
        cell.accessoryType = .None

        cell.setNeedsUpdateConstraints()

        return cell
    }

    // MARK: - UITableViewDelegate Methods

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        let ticker = tickers[indexPath.row]
        let detailController = DetailViewController(ticker: ticker)

        self.navigationController?.pushViewController(detailController, animated: true)
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return TickerCell.defaultHeight
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

        self.symbols.removeAtIndex(indexPath.row)
        self.tickers.removeAtIndex(indexPath.row)

        self.tableView.beginUpdates()

        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)

        self.tableView.endUpdates()
    }

}
