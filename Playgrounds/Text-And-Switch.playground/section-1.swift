// Playground - noun: a place where people can play

import UIKit

let width: CGFloat = 320.0
let height: CGFloat = 44.0

var view: UIView

view = UIView(frame: CGRectMake(0.0, 0.0, width, height))
view.backgroundColor = UIColor.cyanColor()

let textFrame = CGRectMake(5.0, 5.0, width - 10.0, height - 10.0)

var textLabel = UILabel(frame: textFrame)
textLabel.backgroundColor = UIColor.yellowColor()
textLabel.textAlignment = .Center

textLabel.text = "My Text Label"

view.addSubview(textLabel)

var mySwitch = UISwitch(frame: CGRectZero)
mySwitch.tintColor = UIColor.darkGrayColor()

var switchFrame = mySwitch.frame
switchFrame.origin.x = width - (5.0 + switchFrame.size.width)
switchFrame.origin.y = (height - switchFrame.size.height) / 2.0

mySwitch.frame = switchFrame

view.addSubview(mySwitch)

textLabel.textAlignment = .Left

var anotherTextFrame = textLabel.frame
anotherTextFrame.size.width = width - (5.0 + 5.0 + mySwitch.frame.size.width + 5.0)

textLabel.frame = anotherTextFrame

view

view.backgroundColor = UIColor.whiteColor()
view.layer.borderWidth = 0.5
view.layer.borderColor = UIColor.darkGrayColor().CGColor
view.layer.cornerRadius = 5.0

textLabel.backgroundColor = UIColor.clearColor()

view
