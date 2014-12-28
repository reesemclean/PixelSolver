//
//  Board.swift
//  PixelSolver
//
//  Created by Reese McLean on 12/27/14.
//  Copyright (c) 2014 Lunchbox Apps. All rights reserved.
//

import Foundation

let PuzzleFormatItemSeperatorString = ","

public struct Board {
    
    public let rows: [Clue]
    public let columns: [Clue]
    public lazy var solution: Solution = self.createSolution();
    
    public init(rows: [Clue], columns: [Clue]) {
        self.rows = rows
        self.columns = columns
    }
    
    public init?(puzzleFormatString: String) {
        
        let lines = puzzleFormatString.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
        if let (rows, columns) = parseLinesFromPuzzleFormatString(lines) {

            let rowClues = rows.map({ (row: String) -> Clue in
            
                return Clue(fromItemString: row)

            })
            
            self.rows = rowClues
            
            let columnClues = columns.map({ (column: String) -> Clue in
                
                return Clue(fromItemString: column)
                
            })
            
            self.columns = columnClues

            
        } else {
            return nil
        }
        
    }
    
    func createSolution() -> Solution {
        
        return Solution(lines: []);
        
    }
    
}

func parseLinesFromPuzzleFormatString(lines: [String]) -> (rows: [String], columns: [String])? {
    
    if let indexOfRowString = find(lines, "Rows") {
        
        if let indexOfColumnString = find(lines, "Columns") {
            
            if (indexOfColumnString > indexOfRowString) {
                
                let rows = Array(lines[Range(start: indexOfRowString + 1, end: indexOfColumnString)])

                if let indexOfSolutionString = find(lines, "Solution") {
                    
                    if (indexOfSolutionString > indexOfColumnString) {
                        
                        let columns = Array(lines[Range(start: indexOfColumnString + 1, end: indexOfSolutionString)])
                        return (rows, columns)
                    }
                    
                } else {
                    
                    let columns = Array(lines[Range(start: indexOfColumnString + 1, end: lines.count)])
                    return (rows, columns)
                    
                }
                
            }
            
        }
        
    }
    
    return nil
}
