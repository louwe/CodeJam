//
//  main.swift
//  ProblemB
//
//  Created by Edward Louw on 4/8/16.
//  Copyright © 2016 Edward Louw. All rights reserved.
//

import Foundation

func printd(str: String) {
    #if DEBUG
        print(str)
    #endif
}

func printInput(numCases: Int, inputs: [String]) {
    printd(String(numCases))
    for input in inputs {
        printd(input)
    }
}

func printOutput(numCases: Int, solutions: [Int]) {
    for i in 0..<numCases {
        print(String(format: "Case #%d: %d", i+1, solutions[i]))
    }
}

func flipPancakes(pancakes: String) -> String {
    var retVal = ""
    for char in pancakes.characters {
        if char == "-" {
            retVal += "+"
        } else if char == "+" {
            retVal += "-"
        }
    }
    return retVal
}

let numCases = Int(readLine() ?? "0") ?? 0
var caseData = [String]()

for _ in 0..<numCases {
    caseData.append(readLine() ?? "+")
}
printInput(numCases, inputs: caseData)

var solutions = [Int](count: numCases, repeatedValue: 0)

for (i, caseI) in caseData.enumerate() {
    var wasFlipped = false
    var runningPancakes = caseI
    var runningFlipTotal = 0
    repeat {
        wasFlipped = false
        for (j, char) in runningPancakes.characters.enumerate().reverse() {
            if i == 4 {
                printd(String(format: "(%d, %@)", j, "\(char)"))
            }
            if char == "-" {
                var index = runningPancakes.startIndex.advancedBy(j).successor()
                let pancakesToFlip = runningPancakes.substringToIndex(index)
                let pancakesToPreserve = runningPancakes.substringFromIndex(index)
                runningPancakes = flipPancakes(pancakesToFlip) + pancakesToPreserve
                if i == 4 {
                    printd(String(format: "flip(%@) plus %@", pancakesToFlip, pancakesToPreserve))
                    printd(String(format: "newPancakes: %@", runningPancakes))
                }
                wasFlipped = true
                runningFlipTotal += 1
                break
            } else {
                if i == 4 {
                    printd(String(format: "pancakes: %@", runningPancakes))
                }
            }
        }
    } while wasFlipped

    solutions[i] = runningFlipTotal
}

printOutput(numCases, solutions: solutions)
