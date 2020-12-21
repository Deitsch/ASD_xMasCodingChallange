//
//  Day1.swift
//  AOC_Day1
//
//  Created by Simon Deutsch on 21.12.20.
//

import Foundation

class Day1: Day {
    
    func run() {
        let data = FileReader.getStringArray(from: basePath + "Ressources/data.txt").toIntArray()
        print(find2020by3(data: data) ?? "fail")
    }
    
    func find2020(data: [Int], cnt: String) -> Int? {
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
