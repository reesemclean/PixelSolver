//
//  Line.swift
//  PixelSolver
//
//  Created by Reese McLean on 12/27/14.
//  Copyright (c) 2014 Lunchbox Apps. All rights reserved.
//

import Foundation

public struct Clue: Equatable {
    
    public let items: [Int]
    
    public init(items: [Int]) {
        self.items = items;
    }
    
    public init(fromItemString: String) {
        
        let itemsAsStrings: [String] = fromItemString.componentsSeparatedByString(PuzzleFormatItemSeperatorString)
        let itemsAsInts: [Int] = itemsAsStrings.map({ (itemString: String) in
            
            if let item = itemString.toInt() {
                return item
            } else {
                return 0
            }
            
        })
        
        let filteredItems:[Int] = {
            
            if itemsAsInts.count > 1 {
                return itemsAsInts.filter({ item in item > 0 });
            }
            
            return itemsAsInts
            
        }()
        
        self.items = filteredItems
    }
    
}

public func ==(lhs: Clue, rhs: Clue) -> Bool {
    return lhs.items == rhs.items
}