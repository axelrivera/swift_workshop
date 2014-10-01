// Playground - noun: a place where people can play

import UIKit

class MyController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView!

    var dataSource: [[String: String]] = []

    required init(coder aDecoder: NSCoder) {
        assertionFailure("Not Implemented")
    }

    required override init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        self.view = UIView(frame: CGRectMake(0.0, 0.0, 320.0, 480.0))
        self.view.backgroundColor = UIColor.whiteColor()

        tableView = UITableView(frame: self.view.bounds, style: .Grouped)
        tableView.dataSource = self
        tableView.delegate = self

        self.view.addSubview(tableView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateDataSource()
    }

    // MARK: - Private Methods

    func updateDataSource() {
        var rows = [[String: String]]()

        for index in 0..<10 {
            rows.append(["text": "Title Text", "detail": "Detail \(index)"])
        }

        dataSource = rows
        tableView.reloadData()
    }

    // MARK: - UITableViewDataSource Methods

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"

        var cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as UITableViewCell!
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier:CellIdentifier)
        }

        let dictionary = dataSource[indexPath.row]

        cell.textLabel?.text = dictionary["text"]
        cell.detailTextLabel?.text = dictionary["detail"]

        return cell
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Table Header"
    }

    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "The footer is aligned to the left"
    }

    // MARK: UITableViewDelegate Methods

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }

}

var controller = MyController()
controller.view

