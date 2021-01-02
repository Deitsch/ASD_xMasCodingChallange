//
//  Day7.swift
//  AdventOfCode
//
//  Created by Simon Deutsch on 27.12.20.
//

import Foundation

class Bag: Equatable {
    
    var adjective: String
    var color: String
    var bags: [Bag]
    
    init(adjective: String, color: String, bags: [Bag] = []) {
        self.adjective = adjective
        self.color = color
        self.bags = bags
    }
    
    func updateBag(with bag: Bag) {
        if self == bag {
            bags = bag.bags
        }
        bags.forEach{ insideBag in
            insideBag.updateBag(with: bag)
        }
    }
    
    func containsBagWith(adjective: String, color: String) -> Bool {
        if self.adjective == adjective && self.color == color {
            return true
        }
        for bag in bags {
            if bag.containsBagWith(adjective: adjective, color: color) {
                return true
            }
        }
        return false
    }
    
    static func == (lhs: Bag, rhs: Bag) -> Bool {
        return lhs.color == rhs.color && lhs.adjective == rhs.adjective
    }
}


class Day7: Day {
    func run() {
        let data = readData(filename: "day7_input.txt").filter{ !$0.isEmpty }
        
//        let bags = data.map{ readLineToBag(line: $0) }
        var bags = [Bag]()
        var lineCnt = 0
        data.forEach { line in
            let newBag = readLineToBag(line: line)
            bags.forEach{ newBag.updateBag(with: $0 )}
            bags.forEach{ $0.updateBag(with: newBag )}
            bags.append(newBag)
            lineCnt+=1
            print(lineCnt)
        }
        
        let part1 = bags.filter{ !$0.containsBagWith(adjective: "shiny", color: "gold") }.count
        print("Part1", part1)
    }
    
    func readLineToBag(line: String) -> Bag {
        let split = line.split(separator: " ")
        let bag = Bag(adjective: String(split[0]), color: String(split[1]))
        
        guard !line.contains("no other bags") else { return bag }
        
        let endIndex = line.endIndex(of: "contain")!
        bag.bags = line[endIndex..<line.endIndex]
            .replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: "bags", with: "")
            .replacingOccurrences(of: "bag", with: "")
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .flatMap { line -> [Bag] in
                let split = line.split(separator: " ")
                let bagCount = Int(split[0])!
                let bagAdjective = String(split[1])
                let bagColor = String(split[2])
                
                var bags = [Bag]()
                for _ in 0..<bagCount {
                    let insideBag = Bag(adjective: bagAdjective, color: bagColor, bags: [])
                    bags.append(insideBag)
                }
                return bags
            }
        return bag
    }
}
