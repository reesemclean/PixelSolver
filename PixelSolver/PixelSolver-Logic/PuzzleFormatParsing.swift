//
//  PuzzleFormatParsing.swift
//  PixelSolver
//
//  Created by Reese McLean on 12/28/14.
//  Copyright (c) 2014 Lunchbox Apps. All rights reserved.
//

import Foundation

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