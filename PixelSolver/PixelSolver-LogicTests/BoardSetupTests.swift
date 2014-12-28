//
//  BoardSetupTests.swift
//  PixelSolver
//
//  Created by Reese McLean on 12/27/14.
//  Copyright (c) 2014 Lunchbox Apps. All rights reserved.
//

import Foundation
import XCTest
import PixelSolverLogic

class BoardSetupTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testLineSetup() {
        
        let items = [1, 3, 3]
        let line = Clue(items:items)
        
        XCTAssertEqual(line.items.count, items.count, "The number of items in the line should match.")
    }
    
    func testBoardSetup() {
        
        var rows:[Clue] = Array();
        for index in 1...5 {
            //Create 5 lines
            let line = Clue(items: [index, index + 1, index + 4]);
            rows.append(line);
            
        }
        
        var columns:[Clue] = Array();
        for index in 1...5 {
            //Create 5 lines
            let line = Clue(items: [index, index + 1, index + 4]);
            columns.append(line);
        }
        
        let board = Board(rows: rows, columns: columns);
        
        XCTAssertEqual(board.rows.count, rows.count, "The number of rows in the board should match.")
        XCTAssertEqual(board.columns.count, columns.count, "The number of columns in the board should match.")

    }
    
    func testLoadPuzzleOneOntoBoard() {
        
        if let board = loadPuzzle(named: "PuzzleOne") {

            XCTAssertEqual(board.rows.count, 1, "The incorrect number of rows was loaded from puzzle one.")
            XCTAssertEqual(board.rows[0], Clue(items: [1]), "The row clue on puzzle one was not loaded correctly.")
                    
            XCTAssertEqual(board.columns.count, 1, "The incorrect number of columns was loaded from puzzle one.")
            XCTAssertEqual(board.columns[0], Clue(items: [1]), "The column clue on puzzle one was not loaded correctly.")
            
        } else {
            XCTAssert(false, "Unable to load puzzle file.")
        }
        
    }
    
    func testLoadPuzzleTwoOntoBoard() {
        
        if let board = loadPuzzle(named: "PuzzleTwo") {
            
                    XCTAssertEqual(board.rows.count, 2, "The incorrect number of rows was loaded from puzzle one.")
                    XCTAssertEqual(board.rows[0], Clue(items: [1]), "A row clue on puzzle one was not loaded correctly.")
                    XCTAssertEqual(board.rows[1], Clue(items: [1]), "A row clue on puzzle one was not loaded correctly.")

                    XCTAssertEqual(board.columns.count, 2, "The incorrect number of columns was loaded from puzzle one.")
                    XCTAssertEqual(board.columns[0], Clue(items: [0]), "A column clue on puzzle one was not loaded correctly.")
                    XCTAssertEqual(board.columns[1], Clue(items: [2]), "A column clue on puzzle one was not loaded correctly.")
            
        } else {
            XCTAssert(false, "Unable to load puzzle file.")
        }
        
    }
    
    func testLoadPuzzleThreeOntoBoard() {
        
        if let board = loadPuzzle(named: "PuzzleThree") {

            XCTAssertEqual(board.rows.count, 3, "The incorrect number of rows was loaded from puzzle one.")
            XCTAssertEqual(board.rows[0], Clue(items: [1,2]), "A row clue on puzzle one was not loaded correctly.")
            XCTAssertEqual(board.rows[1], Clue(items: [2]), "A row clue on puzzle one was not loaded correctly.")
            XCTAssertEqual(board.rows[2], Clue(items: [1,1]), "A row clue on puzzle one was not loaded correctly.")

            XCTAssertEqual(board.columns.count, 4, "The incorrect number of columns was loaded from puzzle one.")
            XCTAssertEqual(board.columns[0], Clue(items: [2]), "A column clue on puzzle one was not loaded correctly.")
            XCTAssertEqual(board.columns[1], Clue(items: [2]), "A column clue on puzzle one was not loaded correctly.")
            XCTAssertEqual(board.columns[2], Clue(items: [1]), "A column clue on puzzle one was not loaded correctly.")
            XCTAssertEqual(board.columns[3], Clue(items: [1,1]), "A column clue on puzzle one was not loaded correctly.")

        } else {
            XCTAssert(false, "Unable to load puzzle file.")
        }
        
    }
    
    func testBoardSolutionPuzzleOne() {
        
        
        
    }

    func loadPuzzle(named name:String) -> Board? {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        
        if let path = bundle.pathForResource(name, ofType: "txt") {
            
            if let puzzleString = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil) {
                
                if let board = Board(puzzleFormatString: puzzleString) {
                    return board
                }
            }
            
        }
        
        return nil
    }
}
