//
//  ViewController.swift
//  TreeTableView
//
//  Created by Yunus Guezel on 30/06/16.
//  Copyright © 2016 Yunus Guezel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var nodes = [Node]()
    lazy var treeTableView = TreeTableView(style: TreeTableViewStyle.Explore)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nodes = [
            Node(title: "Parent 1", children: [
                Node(title: "Child 1", children: [
                    Node(title: "GrandChild 2"),
                    ]),
                
                Node(title: "Child 1", children: [
                    Node(title: "GrandChild 2"),
                    Node(title: "GrandChild 2")
                    ])
                ]),
            Node(title: "Parent 1", children: [
                Node(title: "Child 1", children: [
                    Node(title: "GrandChild 2"),
                    Node(title: "GrandChild 2"),
                    Node(title: "GrandChild 2")
                    ]),
                Node(title: "Child 1", children: [
                    Node(title: "GrandChild 2"),
                    Node(title: "GrandChild 2"),
                    Node(title: "GrandChild 2"),
                    Node(title: "GrandChild 2"),
                    Node(title: "GrandChild 2"),
                    Node(title: "GrandChild 2"),
                    Node(title: "GrandChild 2")
                    ])
                ]),
            Node(title: "Parent 1", children: [
                Node(title: "Child 1", children: [
                    Node(title: "GrandChild 2"),
                    Node(title: "GrandChild 2"),
                    Node(title: "GrandChild 2"),
                    Node(title: "GrandChild 2"),
                    Node(title: "GrandChild 2"),
                    Node(title: "GrandChild 2"),
                    Node(title: "GrandChild 2")
                    ])
                ]),
        ]
        
        view.addSubview(treeTableView)
        treeTableView.frame = view.bounds
        treeTableView.registerCell(TableViewCell.classForCoder(), forDepth: 0,
                                   forIdentifier: TableViewCell.Identifiers.Header)
        treeTableView.registerCell(TableViewCell.classForCoder(), forDepth: 1,
                                   forIdentifier: TableViewCell.Identifiers.Title)
        treeTableView.registerCell(TableViewCell.classForCoder(), forDepth: 2,
                                   forIdentifier: TableViewCell.Identifiers.SubTitle)
        treeTableView.dataSource = self
    }
    
    func findNode(path: [Int], fromNode node: Node? = nil) -> Node? {
        if path.count == 0 {
            return node
        } else if path.count > 0 {
            let nodes = node?.children ?? self.nodes
            return findNode(path.tail, fromNode: nodes[path.first!])
        }
        return nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension ViewController: TreeTableViewDataSource {
    
    func treeTableView(numberOfChildrenNodesOfPath Path: TreeTablePath) -> Int? {
        let node = findNode(Path.indexes)!
        return node.children.count
    }
    
    func numberOfParentNodes() -> Int {
        return nodes.count
    }
    
    func treeTableView(didDequeCell cell: UITableViewCell, forPath path: TreeTablePath) {
        cell.textLabel?.text = findNode(path.indexes)?.title
    }
}


