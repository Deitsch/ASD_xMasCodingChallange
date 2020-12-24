//
//  Day1.swift
//  AOC_Day1
//
//  Created by Simon Deutsch on 21.12.20.
//

import Foundation

class Day1: Day {
    
    func run() {
        let data = readData(filename: "day1_input.txt").toIntArray()
        print("Part1", find2020(data: data)!)
        print("Part2", find2020by3(data: data)!)
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
    
    // lazy solution
    func find2020by3(data: [Int]) -> Int? {
        for n1 in data {
            for n2 in data {
                for n3 in data {
                    if  n1 + n2 + n3 == 2020 {
                        return n1 * n2 * n3
                    }
                }
            }
        }
        return nil
    }
}
