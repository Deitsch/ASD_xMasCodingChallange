//
//  Day1.swift
//  AOC_Day1
//
//  Created by Simon Deutsch on 21.12.20.
//

import Foundation

class Day1: Day {
    func run() {
        let data = FileReader.getStringArray(from: "/Users/simondeutsch/Documents/Campus/ASD/ASD_xMasCodingChallenge/Ressources/data.txt").toIntArray()
        print(find2020(data: data) ?? "fail")
    }
    
    func find2020(data: [Int]) -> Int? {
        for n1 in data {
            for n2 in data {
                if  n1 + n2 == 2020 {
                    return n1 * n2
                }
            }
        }
        return nil
    }
}
