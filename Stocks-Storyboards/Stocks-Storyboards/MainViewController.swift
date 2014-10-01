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

    override func viewDidLoad() {
        super.viewDidLoad()
        shouldReload = true

        self.refreshControl = UIRefreshControl(frame: CGRectZero)
        self.refreshControl?.addTarget(self, action: "reloadTickers:", forControlEvents: .ValueChanged)
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

    // MARK: - UITableViewDataSource Delegate Methods

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickers.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Config.CellIdentifier, forIndexPath: indexPath) as UITableViewCell

        let ticker = tickers[indexPath.row]

        let symbolLabel = cell.viewWithTag(100) as UILabel
        let amountLabel = cell.viewWithTag(101) as UILabel
        let nameLabel = cell.viewWithTag(102) as UILabel
        let percentLabel = cell.viewWithTag(103) as UILabel

        symbolLabel.text = ticker.symbol
        amountLabel.text = ticker.formattedClose
        nameLabel.text = ticker.name
        percentLabel.text = ticker.priceAndPercentChange
        percentLabel.textColor = ticker.changeColor

        cell.selectionStyle = .Default
        cell.accessoryType = .None
        
        return cell

    }

    // MARK: - UITableViewDelegate Methods

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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

    // MARK: - Transition Methods

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "add" {
            var navController = segue.destinationViewController as UINavigationController
            var addController = navController.topViewController as AddViewController

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

        } else if segue.identifier == "detail" {
            var detailController = segue.destinationViewController as DetailViewController

            var indexPath = self.tableView.indexPathForSelectedRow()

            if let tmp = indexPath {
                var ticker = tickers[tmp.row]
                detailController.dataSource = ticker.toArray()
            }
        }
    }

}
