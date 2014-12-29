//
//  File.swift
//  PixelSolver
//
//  Created by Reese McLean on 12/27/14.
//  Copyright (c) 2014 Lunchbox Apps. All rights reserved.
//

import Foundation

public struct Solution {
    
    public let lines: [SolutionLine]
    
    public init(numberOfRows: Int, numberOfColumns: Int) {
        
        self.lines = Array(count: numberOfRows, repeatedValue: SolutionLine(numberOfCells: numberOfColumns))
        
    }
    
    public init(lines: [SolutionLine]) {
        
        self.lines = lines
        
    }
    
    var solved: Bool {
    
        return self.lines.reduce(true, combine: { (overallStatus: Bool, line: SolutionLine) in
            
            return overallStatus && line.solved
            
        })
        
    }
    
    public func equalToSolutionFromPuzzleFormat(puzzleFormatString: String) -> Bool {
    
        let lines = puzzleFormatString.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
    
        if let solutionLinesFromPuzzleFormat = parseSolutionLinesFromPuzzleFormatString(lines) {

            if (solutionLinesFromPuzzleFormat.count != self.lines.count) {
                return false
            }
            
            for index in Range(start: 0, end: solutionLinesFromPuzzleFormat.count) {
                
                let solutionLineFromPuzzleFormatAsString = solutionLinesFromPuzzleFormat[index]
                let solutionItems = solutionLineFromPuzzleFormatAsString.componentsSeparatedByString(",")
                
                let solutionLineFromSelf = self.lines[index]
                
                if (solutionLineFromSelf.cellStatuses.count != solutionItems.count) {
                    return false
                }
                
                for itemIndex in Range(start: 0, end: solutionLineFromSelf.cellStatuses.count) {
                    
                    let cellStatus = solutionLineFromSelf.cellStatuses[itemIndex]
                    let statusFromPuzzleFormat = solutionItems[itemIndex]
                    
                    switch cellStatus {
                    case .Unknown:
                        return false
                    case .Marked:
                        
                        if (statusFromPuzzleFormat != "#") {
                            return false
                        }
                        
                    case .Unmarked:
                        
                        if (statusFromPuzzleFormat != "-") {
                            return false
                        }
                        
                    }
                    
                }
                
            }
        
        } else {
            return false
        }
        
        return true
    }

}

public struct SolutionLine {
    
    public let cellStatuses: [CellStatus]
    
    init(numberOfCells: Int) {
        
        self.cellStatuses = Array(count: numberOfCells, repeatedValue: .Unknown)
        
    }
    
    var solved: Bool {
        
        return self.cellStatuses.reduce(true, combine: { (overallStatus: Bool, cellStatus: CellStatus) in
          
            return overallStatus && cellStatus != .Unknown
            
        })
        
    }
    
}

public enum CellStatus {
    
    case Unknown
    case Marked
    case Unmarked
    
}
