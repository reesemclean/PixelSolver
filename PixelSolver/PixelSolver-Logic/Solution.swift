//
//  File.swift
//  PixelSolver
//
//  Created by Reese McLean on 12/27/14.
//  Copyright (c) 2014 Lunchbox Apps. All rights reserved.
//

import Foundation

public struct Solution: Equatable {
    
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
                    case .Boxed:
                        
                        if (statusFromPuzzleFormat != "#") {
                            return false
                        }
                        
                    case .Space:
                        
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

public struct SolutionLine: Equatable {
    
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
    case Boxed
    case Space
    
}

public func ==(lhs: Solution, rhs: Solution) -> Bool {
    
    if lhs.lines.count != rhs.lines.count {
        return false
    }
    
    return reduce(Zip2(lhs.lines, rhs.lines), true, { (overallStatus: Bool, solutionTuple: (SolutionLine, SolutionLine)) -> Bool in
        
        let (leftSolutionLine, rightSolutionLine) = solutionTuple
        return overallStatus && leftSolutionLine == rightSolutionLine

    })
    
}

public func ==(lhs: SolutionLine, rhs: SolutionLine) -> Bool {
    
    if lhs.cellStatuses.count != rhs.cellStatuses.count {
        return false
    }
    
    return reduce(Zip2(lhs.cellStatuses, rhs.cellStatuses), true, { (overallStatus: Bool, statusTuple: (CellStatus, CellStatus)) -> Bool in
        
        let (leftStatus, rightStatus) = statusTuple
        return overallStatus && leftStatus == rightStatus
        
    })

}
