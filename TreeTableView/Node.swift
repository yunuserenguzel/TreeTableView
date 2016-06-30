//
//  Node.swift
//  TreeTableView
//
//  Created by Yunus Guezel on 30/06/16.
//  Copyright © 2016 Yunus Guezel. All rights reserved.
//

import Foundation

struct Node {
    
    var title: String
    var children: [Node]
    
    init(title: String, children: [Node] = []) {
        self.title = title
        self.children = children
    }
    
}


