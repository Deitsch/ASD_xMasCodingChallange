//
//  Utils.swift
//  AOC_Day1
//
//  Created by Simon Deutsch on 21.12.20.
//

import Foundation

class FileReader {
    class func getStringArray(from filePath: String) -> [String] {
        let file = try! String(contentsOfFile: filePath)
        return file.components(separatedBy: "\n")
    }
}

extension Array where Element == String {
    func toIntArray() -> [Int] {
        return self.compactMap{ Int($0) }
    }
}

extension StringProtocol {
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        ranges(of: string, options: options).map(\.lowerBound)
    }
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                result.append(range)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
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
