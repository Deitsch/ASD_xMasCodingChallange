//
//  Day4.swift
//  AdventOfCode
//
//  Created by Simon Deutsch on 22.12.20.
//

import Foundation

typealias Passport = [String: String]

class Day4: Day {
    func run() {
        let data = FileReader.getStringArray(from: basePath + "Resources/day4_input.txt")
        
        let rawPassportData = dataToPassportData(data: data)
        
        var validPassports = 0
        rawPassportData.forEach { line in
            let passport = rawPassportDataToPassport(line: line)
            
            if passport.count == 8 || (passport.count == 7 && passport["cid"] == nil) {
                validPassports+=1
            }
        }
        print(validPassports)
    }
    
    // prepare data for each passport to be in one string in the array
    func dataToPassportData(data: [String]) -> [String] {
        var passportData = [String]()
        
        var passportDataLine = ""
        data.forEach { line in
            if !line.isEmpty {
                if !passportDataLine.isEmpty {
                    passportDataLine+=" "
                }
                passportDataLine+=line
            }
            else {
                passportData.append(passportDataLine)
                passportDataLine = ""
            }
        }
        return passportData
    }
    
    // line looks like ->    hcl:231d64 cid:124 ecl:gmt eyr:2039 hgt:189in pid:#9c3ea1
    func rawPassportDataToPassport(line: String) -> Passport {
        var passport = Passport()
        
        let fields = line.split(separator: " ")
        
        fields.forEach{ field in
            let split = field.split(separator: ":")
            let key = split[0]
            let value = split[1]
            passport[String(key)] = String(value)
        }
        return passport
    }
}
