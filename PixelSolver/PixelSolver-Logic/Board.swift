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
    public lazy var solution: Solution = self.solve(nil);
    
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
    
    func solve(partialSolution: Solution?) -> Solution {
        
        let currentSolution: Solution = {
            
            if (partialSolution == nil) {
                return Solution(numberOfRows: self.rows.count, numberOfColumns: self.columns.count)
            } else {
                return partialSolution!
            }
            
        }()
        
        if (currentSolution.solved) {
            return currentSolution
        }
        
        let solutionLines = map(Zip2(self.rows, currentSolution.lines), { (clue: Clue, solutionLine: SolutionLine) -> SolutionLine in
            //return SolutionLine(numberOfCells: )
            let solutionLineAfterPunctuatingSpaces = self.solutionLinePunctuatingSpaces(clue, solutionLine: solutionLine)
            let solutionLineAfterCheckingForOverlaps = self.solutionLineCheckingForOverlaps(clue, solutionLine:solutionLineAfterPunctuatingSpaces)
            
            return solutionLineAfterCheckingForOverlaps
        })
        
        if (false) { //Unsolvable case
            return currentSolution
        }
        
        return solve(currentSolution)
        
    }
    
    func solutionLinePunctuatingSpaces(clue: Clue, solutionLine: SolutionLine) -> SolutionLine {
        
        
        
    }
    
    func solutionLineCheckingForOverlaps(clue: Clue, solutionLine: SolutionLine) -> SolutionLine {
        
    }
    
}
