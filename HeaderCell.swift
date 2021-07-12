//
//  HeaderCell.swift
//  BasketballBible
//
//  Created by Muji on 2020-10-08.
//  Copyright © 2020 Muji. All rights reserved.
//

/**
 Custom Header Cell inheriting Cell, used in SpreadSheetView
 */
import UIKit
import SpreadsheetView


class HeaderCell: Cell {
    let label = UILabel()
    let sortArrow = UILabel()

    override var frame: CGRect {
        didSet {
            label.frame = bounds.insetBy(dx: 0, dy: 0)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.frame = bounds
        label.backgroundColor = UIColor.gray
        
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 1
        contentView.addSubview(label)

        sortArrow.text = ""
        sortArrow.font = UIFont.boldSystemFont(ofSize: 14)
        sortArrow.textAlignment = .center
        contentView.addSubview(sortArrow)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        sortArrow.sizeToFit()
        sortArrow.frame.origin.x = frame.width - sortArrow.frame.width - 8
        sortArrow.frame.origin.y = (frame.height - sortArrow.frame.height) / 2
    }
}

class TextCell: Cell {
    let label = UILabel()

    override var frame: CGRect {
        didSet {
            label.frame = bounds.insetBy(dx: 4, dy: 2)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.2)
        selectedBackgroundView = backgroundView

        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        

        contentView.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
