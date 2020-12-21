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
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    func nextPosition() {
        x+=3
        y+=1
    }
}

class Day3: Day {
    
    var mapWidth: Int?
    var mapHeight: Int?
    
    func run() {
        let data = FileReader.getStringArray(from: basePath + "/Ressources/day3_input.txt")
        mapWidth = data.first?.count
        mapHeight = data.count
        
        let plane = Airplane(x: 0, y: 0)
        
        var collisions = 0
        
        while plane.y < mapHeight! - 1 {
            print(plane.x, plane.y)
            if didCollide(plane: plane, map: data) {
                collisions+=1
            }
            plane.nextPosition()
        }
        
        print(collisions)
    }
    
    func didCollide(plane: Airplane, map: [String]) -> Bool {
        let xPos = plane.x % mapWidth! // % width because repeating map!
        return Array(map[plane.y])[xPos] == "#"
    }
}
