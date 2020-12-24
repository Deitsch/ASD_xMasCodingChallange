//
//  Day3.swift
//  AdventOfCode
//
//  Created by Simon Deutsch on 21.12.20.
//

import Foundation

class Airplane {
    var x: Int
    var y: Int
    
    private var movementPattern: AirplaneMovementPattern
    
    init(x: Int, y: Int, pattern: AirplaneMovementPattern) {
        self.x = x
        self.y = y
        self.movementPattern = pattern
    }
    
    func nextPosition() {
        (x, y) = movementPattern.nextPosition(x: x, y: y)
    }
}

enum AirplaneMovementPattern: CaseIterable {
    case r1d1
    case r3d1
    case r7d1
    case r1d2
    case r5d1
}

extension AirplaneMovementPattern {
    func nextPosition(x: Int, y: Int) -> (Int, Int) {
        switch self {
        case .r1d1:
            return (x+1, y+1)
        case .r3d1:
            return (x+3, y+1)
        case .r7d1:
            return (x+7, y+1)
        case .r1d2:
            return (x+1, y+2)
        case .r5d1:
            return (x+5, y+1)
        }
    }
}


class Day3: Day {
    
    var mapWidth: Int?
    var mapHeight: Int?
    
    func run() {
        let map = readData(filename: "day3_input.txt")
        mapWidth = map.first?.count
        mapHeight = map.count
        
        
        var multipliedCollisions = 1
        AirplaneMovementPattern.allCases.forEach { pattern in
            let plane = Airplane(x: 0, y: 0, pattern: pattern)
            multipliedCollisions *= getCollisions(plane: plane, map: map)
        }
        print(multipliedCollisions)
    }
    
    func getCollisions(plane: Airplane, map: [String]) -> Int {
        var collisions = 0
        
        while plane.y < mapHeight! - 1 {
            print(plane.x, plane.y)
            if didCollide(plane: plane, map: map) {
                collisions+=1
            }
            plane.nextPosition()
        }
        return collisions
    }
    
    func didCollide(plane: Airplane, map: [String]) -> Bool {
        let xPos = plane.x % mapWidth! // % width because repeating map!
        return Array(map[plane.y])[xPos] == "#"
    }
}
