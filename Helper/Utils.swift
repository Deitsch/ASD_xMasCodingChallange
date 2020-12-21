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
