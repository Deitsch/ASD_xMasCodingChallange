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
    
    func contains(bag: Bag) -> Bool {
        if self == bag {
            return true
        }
        for insideBag in bags {
            if insideBag.contains(bag: bag) {
                return true
            }
        }
        return false
    }
    
    static func == (lhs: Bag, rhs: Bag) -> Bool {
        return lhs.color == rhs.color && lhs.adjective == rhs.adjective
    }
}


class Day7_simon: Day {
    func run() {
        let data = readData(filename: "day7_input.txt").filter{ !$0.isEmpty }
        
//        let bags = data.map{ readLineToBag(line: $0) }
        var bags = [Bag]()
        data.forEach { line in
            let newBag = readLineToBag(line: line)
            bags.forEach{ newBag.updateBag(with: $0 )}
            bags.forEach{ $0.updateBag(with: newBag )}
            bags.append(newBag)
        }
        
        let searchBag = Bag(adjective: "shiny", color: "gold")
        let part1 = bags
            .filter { $0 != searchBag }
            .filter { $0.contains(bag: searchBag) }.count
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
            .compactMap { line in
                let split = line.split(separator: " ")
                let bagAdjective = String(split[1])
                let bagColor = String(split[2])
                
                return Bag(adjective: bagAdjective, color: bagColor, bags: [])
            }
        return bag
    }
}
