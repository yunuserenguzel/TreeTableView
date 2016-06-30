//
//  ViewController.swift
//  TreeTableView
//
//  Created by Yunus Guezel on 30/06/16.
//  Copyright © 2016 Yunus Guezel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TreeTableViewDataSource {

    var nodes = [Node]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nodes = [
            Node(title: "Parent 1", children: [
                Node(title: "Child 1", children: [
                    Node(title: "GrandChild 2"),
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
                    Node(title: "GrandChild 2")
                    ])
                ]),
            Node(title: "Parent 1", children: [
                Node(title: "Child 1", children: [
                    Node(title: "GrandChild 2"),
                    Node(title: "GrandChild 2"),
                    Node(title: "GrandChild 2")
                    ])
                ]),
        ]
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func findNode(parent: Node, path: [Int]) -> Node {
        return nodes.first!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func treeTableView(treeTableView _: TreeTableView, numberOfChildrenNodesOfPath Path: TreeTablePath) -> Int? {
        guard let tailPath = Path.tailPath else { return nil }
        let node = findNode(nodes[Path.parentIndex], path: tailPath.indexes)
        return node.children.count
    }
    
    func numberOfParentNodes(treeTableView _: TreeTableView) -> Int {
        return nodes.count
    }
    

}

