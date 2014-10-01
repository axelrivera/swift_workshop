//
//  TickerListCell.swift
//  MarketStops
//
//  Created by Axel Rivera on 7/5/14.
//  Copyright (c) 2014 Axel Rivera. All rights reserved.
//

import UIKit

class TickerCell: UITableViewCell {

    struct Config {
        static let topPadding: CGFloat = 10.0
        static let bottomPadding: CGFloat = 10.0
        static let leftPadding: CGFloat = 10.0
        static let rightPadding: CGFloat = 10.0
    }

    let symbolLabel: UILabel!
    let nameLabel: UILabel!
    let priceLabel: UILabel!
    let supportLabel: UILabel!

    class var defaultHeight: CGFloat {
        return 84.0
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(reuseIdentifier: String!) {
        super.init(style: .Default, reuseIdentifier: reuseIdentifier)

        self.opaque = true

        symbolLabel = UILabel(frame: CGRectZero)
        symbolLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        symbolLabel.font = UIFont.systemFontOfSize(28.0)
        symbolLabel.textAlignment = .Left
        symbolLabel.textColor = UIColor.blackColor()

        contentView.addSubview(symbolLabel)

        nameLabel = UILabel(frame: CGRectZero)
        nameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        nameLabel.font = UIFont.systemFontOfSize(12.0)
        nameLabel.textAlignment = .Left
        nameLabel.textColor = UIColor.grayColor()

        contentView.addSubview(nameLabel)

        priceLabel = UILabel(frame: CGRectZero)
        priceLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        priceLabel.font = UIFont.systemFontOfSize(26.0)
        priceLabel.textAlignment = .Right
        priceLabel.textColor = UIColor.blackColor()

        contentView.addSubview(priceLabel)

        supportLabel = UILabel(frame: CGRectZero)
        supportLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        supportLabel.font = UIFont.systemFontOfSize(14.0)
        supportLabel.textAlignment = .Left
        supportLabel.textColor = UIColor.redColor()

        contentView.addSubview(supportLabel)
    }

    override func updateConstraints() {
        symbolLabel.autoPinEdge(.Top, toEdge: .Left, ofView: nameLabel, withOffset: 3.0)
        symbolLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: Config.leftPadding)

        nameLabel.autoPinEdgeToSuperviewEdge(.Bottom, withInset: Config.bottomPadding)
        nameLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: Config.leftPadding)

        priceLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: Config.topPadding)
        priceLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: Config.rightPadding)

        supportLabel.autoPinEdgeToSuperviewEdge(.Bottom, withInset: Config.bottomPadding)
        supportLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: Config.rightPadding)

        priceLabel.autoPinEdge(.Left, toEdge: .Right, ofView: symbolLabel, withOffset: 2.0)
        nameLabel.autoPinEdge(.Right, toEdge: .Left, ofView: supportLabel, withOffset:-2.0)

        super.updateConstraints()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
