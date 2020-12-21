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
            if isPasswordValid(line: line, company: .TobogganCorporate) {
                correctPWs+=1
            }
        }
        print(correctPWs)
    }
//    1-3 a: abcde
    func isPasswordValid(line: String, company: Company) -> Bool {
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
        guard let ruleChar = split2[1].first else {
            return false
        }
        
        let password = String(split2[2])
        
        return company.evaluate(password: password, ruleChar: ruleChar, min: min, max: max)
    }
}

enum Company {
    case TobogganCorporate
    case SledRental
}

extension Company {
    
    func evaluate(password: String, ruleChar: Character, min: Int, max: Int) -> Bool {
        switch self {
        case .TobogganCorporate:
            return TobogganCorporateRule(password: password, ruleChar: ruleChar, min: min, max: max)
        case .SledRental:
            return SledRentalRule(password: password, ruleChar: ruleChar, min: min, max: max)
        }
    }
    
    private func SledRentalRule(password: String, ruleChar: Character, min: Int, max: Int) -> Bool {
        var occurences = 0
        password.forEach{ char in
            if char == ruleChar {
                occurences+=1
            }
        }
        
        return occurences >= min && occurences <= max
    }

    private func TobogganCorporateRule(password: String, ruleChar: Character, min: Int, max: Int) -> Bool {
        if password.count < max { return false }
        
        
        let check1 = Array(password)[min - 1] == ruleChar
        let check2 = Array(password)[max - 1] == ruleChar
        
        switch (check1, check2) {
        case (false, false), (true, true):
            return false
        case (true, false), (false, true):
            return true
        }
    }
}

