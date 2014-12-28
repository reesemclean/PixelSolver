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
    
    init(lines: [SolutionLine]) {
        self.lines = lines;
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
                    
                    if (cellStatus == true) {
                        
                        if (statusFromPuzzleFormat != "#") {
                            return false
                        }
                        
                    } else {
                        
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
    
    func parseSolutionLinesFromPuzzleFormatString(lines: [String]) -> [String]? {
        
        let possibleIndexOfSolutionString = find(lines, "Solution")
        
        if (possibleIndexOfSolutionString == nil) {
            return nil
        }
        
        let indexOfSolutionString = possibleIndexOfSolutionString!
        
        if let indexOfRowString = find(lines, "Rows") {

            if (indexOfRowString > indexOfSolutionString) {
                return nil;
            }
            
        }
        
        if let indexOfColumnString = find(lines, "Columns") {
            
            if (indexOfColumnString > indexOfSolutionString) {
                return nil;
            }
            
        }
        
        return Array(lines[Range(start: indexOfSolutionString + 1, end: lines.count)])

    }

}

public struct SolutionLine {
    
    public let cellStatuses: [Bool]
    
    init(cellStatuses: [Bool]) {
        self.cellStatuses = cellStatuses
    }
    
}