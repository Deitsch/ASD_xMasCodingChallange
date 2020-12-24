//
//  Day.swift
//  AOC_Day1
//
//  Created by Simon Deutsch on 21.12.20.
//

import Foundation

let basePath = "/Users/simondeutsch/Documents/Campus/ASD/ASD_xMasCodingChallenge/Resources/"

protocol Day {
    
    func run()
    func readData(filename: String) -> [String]
}

extension Day {
    func readData(filename: String) -> [String] {
        return FileReader.getStringArray(from: basePath + filename)
    }
}

