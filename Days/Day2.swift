//
//  Day2.swift
//  AdventOfCode
//
//  Created by Simon Deutsch on 21.12.20.
//

import Foundation

class Day2: Day {
    func run() {
        let data = FileReader.getStringArray(from: "/Users/simondeutsch/Documents/Campus/ASD/ASD_xMasCodingChallenge/Ressources/day2_input.txt")
        
        var correctPWs = 0
        data.forEach { line in
            if isPasswordValid(line: line) {
                correctPWs+=1
            }
        }
        print(correctPWs)
    }
//    1-3 a: abcde
    func isPasswordValid(line: String) -> Bool {
        if line.isEmpty { return false }
        
//       [0] 1
//       [1] 3 a: abcde
        let split1 = line.split(separator: "-")
        guard let min = Int(String(split1[0])) else {
            return false
        }

//       [0] 3
//       [1] a:
//       [2] abcde
        let split2 = split1[1].split(separator: " ")
        guard let max = Int(String(split2[0])) else {
            return false
            
        }
        let ruleChar = split2[1].first
        let password = split2[2]
        
        var occurences = 0
        password.forEach{ char in
            if char == ruleChar {
                occurences+=1
            }
        }
        
        return occurences >= min && occurences <= max
    }
}
