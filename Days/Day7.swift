//
//  Day7.swift
//  AdventOfCode
//
//  Created by Johannes Schumeth on 30.12.20.
//

import Foundation

typealias RuleMap = [String : [String]]

class Day7: Day {
    func run() {
        let data = readData(filename: "day7_input.txt")
        let ruleMap = mapDataToRuleMap(data: data)
        let wantedBag = "shiny gold bag"
        var numberOfBagsContainingWantedBag = 0
        
        ruleMap.keys.forEach { bag in
            if(wantedBagInChildBags(bag: bag, wantedBag: wantedBag, ruleMap: ruleMap)) {
                numberOfBagsContainingWantedBag += 1
            }
        }
        
        let numberOfChildBags = countChildBags(bag: wantedBag, ruleMap: ruleMap)
        
        print("Part1", numberOfBagsContainingWantedBag)
        print("Part2", numberOfChildBags)
    }
    
    func mapDataToRuleMap(data: [String]) -> RuleMap {
        var ruleMap = RuleMap()
        
        data.forEach { line in
            if !line.isEmpty {
                let bag = line.substring(upTo: " contain ").removeTrailingCharacter(trailingChar: "s")
                let childBags = line.substring(fromExcluded: " contain ").substring(upTo: ".")
                
                if(childBags == "no other bags") {
                    ruleMap[bag] = [String]()
                }
                else {
                    ruleMap[bag] = childBags.components(separatedBy: ", ")
                        .map{ $0.removeTrailingCharacter(trailingChar: "s") }
                }
            }
        }
        
        return ruleMap
    }
    
    func wantedBagInChildBags(bag: String, wantedBag: String, ruleMap: RuleMap) -> Bool {
        let childBags = ruleMap[bag]
        var wantedBagFound = false
        
        for childBag in childBags! {
            let childBagWithoutNumber = childBag.substring(fromExcluded: " ")
            
            if(childBagWithoutNumber == wantedBag) {
                return true
            }
            else {
                wantedBagFound = wantedBagFound
                    || wantedBagInChildBags(bag: childBagWithoutNumber, wantedBag: wantedBag, ruleMap: ruleMap)
            }
        }
        
        return wantedBagFound
    }
    
    func countChildBags(bag: String, ruleMap: RuleMap) -> Int {
        let childBags = ruleMap[bag]
        var numberOfChildBags = 0
        
        for childBag in childBags! {
            let number = Int(childBag.substring(upTo: " "))!
            numberOfChildBags += number
            
            let childBagWithoutNumber = childBag.substring(fromExcluded: " ")
            numberOfChildBags += number * countChildBags(bag: childBagWithoutNumber, ruleMap: ruleMap)
        }
        
        return numberOfChildBags
    }
}

extension String {
    func firstIndex(of: String) -> Int {
        if let range: Range<String.Index> = self.range(of: of) {
            let index: Int = self.distance(from: self.startIndex, to: range.lowerBound)
            return index
        }
        else {
            return -1
        }
    }

    func substring(upTo: String) -> String {
        return String(self.prefix(self.firstIndex(of: upTo)))
    }
    
    func substring(fromExcluded: String) -> String {
        let offset = self.firstIndex(of: fromExcluded) + fromExcluded.count
        let fromIndex = self.index(startIndex, offsetBy: offset)
        return String(self[fromIndex...])
    }
    
    func removeTrailingCharacter(trailingChar: Character) -> String {
        return self.last! == trailingChar ? String(self.dropLast()) : self
    }
}
