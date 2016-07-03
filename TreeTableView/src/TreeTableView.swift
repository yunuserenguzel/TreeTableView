//
//  TreeTableView.swift
//  TreeTableView
//
//  Created by Yunus Guezel on 30/06/16.
//  Copyright © 2016 Yunus Guezel. All rights reserved.
//

import UIKit

enum TreeTableViewStyle {
    
    case Explore
    case Focused
    case Compact
    
}

public class TreeTableView: UIView {
    
    private lazy var tableView = UITableView(frame: CGRect.zero, style: .Plain)
    
    let style: TreeTableViewStyle
    
    internal var treeTableController: TreeTableController!
    
    public weak var dataSource: TreeTableViewDataSource? {
        get {
            return treeTableController.dataSource
        }
        set {
            treeTableController.dataSource = newValue
        }
    }
    
    init(style: TreeTableViewStyle) {
        self.style = style
        super.init(frame: CGRect.zero)
        switch style {
        case .Focused:
            self.treeTableController = TreeTableFocusController(tableView: tableView)
        case .Compact:
            self.treeTableController = TreeTableCompactController(tableView: tableView)
        default:
            self.treeTableController = TreeTableExploreController(tableView: tableView)
        }
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.style = .Explore
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        addSubview(tableView)
        tableView.tableFooterView = UIView()
        tableView.dataSource = treeTableController
        tableView.delegate = treeTableController
        tableView.separatorStyle = .None
    }
    
    override public func layoutSubviews() {
        tableView.frame = bounds
        super.layoutSubviews()
    }
    
    func registerCell(cellClass: AnyClass, forDepth depth: Int, forIdentifier identifier: String) {
        tableView.registerClass(cellClass, forCellReuseIdentifier: identifier)
        treeTableController.registerCell(depth: depth, identifier: identifier)
    }

}


