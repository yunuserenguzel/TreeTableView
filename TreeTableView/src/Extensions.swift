//
//  Extensions.swift
//  TreeTableView
//
//  Created by Yunus Eren Guzel on 30/06/16.
//  Copyright © 2016 Yunus Guezel. All rights reserved.
//

import Foundation

extension Int {
    
    func toRange() -> Range<Int> {
        return (0..<self)
    }
    
}

extension Array {
    
    var tail: [Element] {
        let range = (1..<count)
        return Array(self[range])
    }
    
}
