//
//  TableViewCell.swift
//  TreeTableView
//
//  Created by Yunus Eren Guzel on 30/06/16.
//  Copyright © 2016 Yunus Guezel. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    struct Identifiers {
        static let Header = "Header"
        static let Title  = "Title"
        static let SubTitle = "SubTitle"
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if reuseIdentifier == Identifiers.Header {
            textLabel?.font = UIFont.boldSystemFontOfSize(28)
        }
        if reuseIdentifier == Identifiers.Title {
            textLabel?.font = UIFont.boldSystemFontOfSize(22)
        }
        if reuseIdentifier == Identifiers.SubTitle {
            textLabel?.font = UIFont.systemFontOfSize(18)
        }
        selectionStyle = .None
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
