//
//  Day6.swift
//  AdventOfCode
//
//  Created by Simon Deutsch on 24.12.20.
//

import Foundation

struct GroupAnswer {
    var answers: String
    var memberCount: Int
}

class Day6: Day {
    func run() {
        let data = readData(filename: "day6_input.txt")
        
        let groupAnswers = groupAnswersByGroup(data: data)
        let groupAnswersNoDuplicates = removeDuplicates(from: groupAnswers.map{ $0.answers })
        
        let totalYes = groupAnswersNoDuplicates.map { $0.count }.reduce(0, { $0 + $1 })
        print("Part1", totalYes)
        
        let commonYes = groupAnswers.map{ getCommonAnswers(from: $0).count }.reduce(0, { $0 + $1 })
        print("Part2", commonYes)
    }
    
    func groupAnswersByGroup(data: [String]) -> [GroupAnswer] {
        var groups = [GroupAnswer]()
        var flattend = ""
        var groupMemberCount = 0
        data.forEach { line in
            if !line.isEmpty {
                groupMemberCount+=1
                flattend.append(line)
            }
            else {
                groups.append(GroupAnswer(answers: flattend, memberCount: groupMemberCount))
                flattend = ""
                groupMemberCount = 0
            }
        }
        return groups
    }
    
    func removeDuplicates(from groups: [String]) -> [String] {
        groups.map { String(Array(Set(Array($0)))) }
    }
    
    func getCommonAnswers(from group: GroupAnswer) -> String {
        var commonAnswers = ""
        let noDuplicateAnswers = String(Array(Set(Array(group.answers))))
        noDuplicateAnswers.forEach{ answer in
            if group.answers.filter({ $0 == answer}).count == group.memberCount {
                commonAnswers.append(answer)
            }
        }
        return commonAnswers
    }
}
