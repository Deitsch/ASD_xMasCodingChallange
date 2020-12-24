//
//  Day5.swift
//  AdventOfCode
//
//  Created by Simon Deutsch on 24.12.20.
//

import Foundation

typealias SeatMap = [[Int]]

class Day5: Day {
    func run() {
        let data = readData(filename: "day5_input.txt")
        
        var highestSeatID = 0
        var lowestSeatID = Int.max
        var seatIDs = [Int]()
        
        data.forEach{ line in
            if !line.isEmpty {
                let seatID = calculateSeatID(line: line)
                seatIDs.append(seatID)
                highestSeatID = seatID > highestSeatID ? seatID : highestSeatID
                lowestSeatID = seatID < lowestSeatID ? seatID : lowestSeatID
            }
        }
        print("Part1", highestSeatID)
        
        let allSeatsMap = calculateAllPossibleSeatIDs(cols: 8, rows: 128)
        let reducedFlatSeats = removeRowsBetween(lowerbound: lowestSeatID, upperbound: highestSeatID, in: allSeatsMap).flatMap { $0 }
        let possibleSeats = Set(reducedFlatSeats).symmetricDifference(Set(seatIDs))
        
        possibleSeats.forEach { seatID in
            if seatIDs.contains(seatID + 1) && seatIDs.contains(seatID - 1) {
                print("Part2", seatID)
            }
        }
    }
    
    
    func removeRowsBetween(lowerbound: Int, upperbound: Int, in map: SeatMap) -> SeatMap {
        var removeCnt = 0
        for col in map {
            if col.contains(lowerbound) {
                break
            }
            removeCnt+=1
        }
        let removedFirst = map.dropFirst(removeCnt)
        
        
        removeCnt = 0
        for col in removedFirst.reversed() {
            if col.contains(upperbound) {
                break
            }
            removeCnt+=1
        }
        return removedFirst.dropLast(removeCnt)
    }
    
    func calculateSeatID(line: String) -> Int {
        // split string 0-6 = row  7-9 = col
        let rowCode = line.replacingOccurrences(of: "R", with: "").replacingOccurrences(of: "L", with: "")
        let colCode = line.replacingOccurrences(of: "F", with: "").replacingOccurrences(of: "B", with: "")
        
        let row = calculateSeatFrom(code: rowCode, lowerBound: 0, upperBound: 127)
        let col = calculateSeatFrom(code: colCode, lowerBound: 0, upperBound: 7)
        
        return calculateSeatID(col: col, row: row)
    }
    
    func calculateSeatID(col: Int, row: Int) -> Int {
        return row * 8 + col
    }
    
    func calculateSeatFrom(code: String, lowerBound: Int, upperBound: Int) -> Int {
        let checkChar = (code.contains("L") ? "L" : "F").first
        if abs(upperBound - lowerBound) == 1 {
            return code.first == checkChar ? lowerBound : upperBound
        }
        
        let half: Int = (upperBound - lowerBound) / 2 + lowerBound
        
        let newLowerBound = code.first == checkChar ? lowerBound : half + 1
        let newUpperBound = code.first == checkChar ? half : upperBound
        let newCode = String(code.dropFirst())
        
        return calculateSeatFrom(code: newCode, lowerBound: newLowerBound, upperBound: newUpperBound)
    }
    
    func calculateAllPossibleSeatIDs(cols: Int, rows: Int) -> SeatMap{
        var seatMap = SeatMap()
        
        for row in 0..<rows {
            seatMap.append([Int]())
            for col in 0..<cols {
                seatMap[row].append(calculateSeatID(col: col, row: row))
            }
        }
        return seatMap
    }
}
