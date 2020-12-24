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
        let data = readData(filename: "day4_input.txt")
        
        let rawPassportData = dataToPassportData(data: data)
        
        var validPassportsP1 = 0
        var validPassportsP2 = 0
        rawPassportData.forEach { line in
            let passport = rawPassportDataToPassport(line: line)
            
            if passport.count == 8 || (passport.count == 7 && passport["cid"] == nil) {
                validPassportsP1+=1
                if additionalCheck(passport: passport) {
                    validPassportsP2+=1
                }
            }
        }
        print("Part1", validPassportsP1)
        print("Part2", validPassportsP2)
    }
    
    func additionalCheck(passport: Passport) -> Bool {
        guard let byr = Int(passport["byr"]!), byr >= 1920 && byr <= 2002 else {
            return false
        }
        guard let iyr = Int(passport["iyr"]!), iyr >= 2010 && iyr <= 2020 else {
            return false
        }
        guard let eyr = Int(passport["eyr"]!), eyr >= 2020 && eyr <= 2030 else {
            return false
        }
        guard let hgt = passport["hgt"], hgt.hasSuffix("cm") || hgt.hasSuffix("in") else {
            return false
        }
        
        if hgt.hasSuffix("cm") {
            guard let cmHeight = Int(hgt.replacingOccurrences(of: "cm", with: "")), cmHeight >= 150 && cmHeight <= 193 else {
                return false
            }
        }
        else {
            guard let cmHeight = Int(hgt.replacingOccurrences(of: "in", with: "")), cmHeight >= 59 && cmHeight <= 76 else {
                return false
            }
        }
        
        let regexHcl = try! NSRegularExpression(pattern: "^#[0-9a-f]{6}$")
        guard let hcl = passport["hcl"],
              regexHcl.firstMatch(in: hcl, options: [], range: NSRange(location: 0, length: hcl.count)) != nil else {
            return false
        }
        
        let validEyeColors = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
        guard let ecl = passport["ecl"], validEyeColors.contains(ecl) else {
            return false
        }
        
        let regexPid = try! NSRegularExpression(pattern: "^[0-9]{9}$")
        guard let pid = passport["pid"],
              regexPid.firstMatch(in: pid, options: [], range: NSRange(location: 0, length: pid.count)) != nil else {
            return false
        }
        
        return true
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
