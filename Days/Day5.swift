//
//  Day5.swift
//  AdventOfCode
//
//  Created by Simon Deutsch on 24.12.20.
//

import Foundation

class Day5: Day {
    func run() {
        let data = FileReader.getStringArray(from: basePath + "Resources/day5_input.txt")
    
        var highestSeatID = 0
        data.forEach{ line in
            if !line.isEmpty {
                let seatID = calculateSeatID(line: line)
                highestSeatID = seatID > highestSeatID ? seatID : highestSeatID
            }
        }
        
        print("Part1", highestSeatID)
    }
    
    func calculateSeatID(line: String) -> Int {
        // split string 0-6 = row  7-9 = col
        let rowCode = line.replacingOccurrences(of: "R", with: "").replacingOccurrences(of: "L", with: "")
        let colCode = line.replacingOccurrences(of: "F", with: "").replacingOccurrences(of: "B", with: "")
        
        
        let row = calculateSeatRow(rowString: rowCode, lowerBound: 0, upperBound: 127)
        let col = calculateSeatColumn(colString: colCode, lowerBound: 0, upperBound: 7)
        
        return row * 8 + col
    }
    
    
    // calcSeat and calcRow are almost the same -> could be 1 function with bounderies identifier
    func calculateSeatRow(rowString: String, lowerBound: Int, upperBound: Int) -> Int {
        if abs(upperBound - lowerBound) == 1 {
            return rowString.first == "F" ? lowerBound : upperBound
        }
        
        let half: Int = (upperBound - lowerBound) / 2 + lowerBound
        
        let newLowerBound = rowString.first == "F" ? lowerBound : half + 1
        let newUpperBound = rowString.first == "F" ? half : upperBound
        let newRowString = String(rowString.dropFirst())
        
        return calculateSeatRow(rowString: newRowString, lowerBound: newLowerBound, upperBound: newUpperBound)
    }
    
    func calculateSeatColumn(colString: String, lowerBound: Int, upperBound: Int) -> Int {
        if abs(upperBound - lowerBound) == 1 {
            return colString.first == "L" ? lowerBound : upperBound
        }
        
        let half: Int = (upperBound - lowerBound) / 2 + lowerBound
        
        let newLowerBound = colString.first == "L" ? lowerBound : half + 1
        let newUpperBound = colString.first == "L" ? half : upperBound
        let newColString = String(colString.dropFirst())
        
        return calculateSeatColumn(colString: newColString, lowerBound: newLowerBound, upperBound: newUpperBound)
    }
}
