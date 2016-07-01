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

class TreeTableView: UIView {
    
    private lazy var tableView = UITableView(frame: CGRect.zero, style: .Plain)
    
    let style: TreeTableViewStyle
    
    internal let pathBuilder: PathBuilder
    
    internal var paths = [TreeTablePath]()
    
    internal var registeredCells = [Int: String]()
    
    weak var dataSource: TreeTableViewDataSource? {
        didSet {
            guard let dataSource = self.dataSource else { return }
            dispatch_async(dispatch_get_main_queue()) {
                self.paths = self.pathBuilder.buildPaths(dataSource)
                self.tableView.reloadData()
            }
        }
    }
    
    init(style: TreeTableViewStyle) {
        self.style = style
        self.pathBuilder = ExplorePathBuilder()
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        self.style = .Explore
        self.pathBuilder = ExplorePathBuilder()
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        addSubview(tableView)
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .None
    }
    
    override func layoutSubviews() {
        tableView.frame = bounds
        super.layoutSubviews()
    }
    
    func registerCell(cellClass: AnyClass, forDepth depth: Int, forIdentifier identifier: String) {
        registeredCells[depth] = identifier
        tableView.registerClass(cellClass, forCellReuseIdentifier: identifier)
    }
    
    private func numberOfNodes() -> Int {
        return paths.count
    }
    
}


