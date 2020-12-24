//
//  Day6.swift
//  AdventOfCode
//
//  Created by Simon Deutsch on 24.12.20.
//

import Foundation

class Day6: Day {
    func run() {
        let data = readData(filename: "day6_input.txt")
        
        let groupAnswers = groupAnswersByGroup(data: data)
        let groupAnswersNoDuplicates = removeDuplicates(from: groupAnswers)
        
        let totalYes = groupAnswersNoDuplicates.map { $0.count }.reduce(0, { $0 + $1 })
        print("Part1", totalYes)
    }
    
    func groupAnswersByGroup(data: [String]) -> [String] {
        var groups = [String]()
        var flattend = ""
        data.forEach { line in
            if !line.isEmpty {
                flattend.append(line)
            }
            else {
                groups.append(flattend)
                flattend = ""
            }
        }
        return groups
    }
    
    func removeDuplicates(from groups: [String]) -> [String] {
        groups.map { String(Array(Set(Array($0)))) }
    }
}
