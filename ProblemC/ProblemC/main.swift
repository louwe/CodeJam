//
//  main.swift
//  ProblemC
//
//  Created by Edward Louw on 4/8/16.
//  Copyright © 2016 Edward Louw. All rights reserved.
//

import Foundation

extension UInt {
    var isPrime: (yes: Bool, divisor: UInt) {
        var retVal: (Bool, UInt) = (true, 0)
        if self <  2 { return (false, 2) }
        let squareRoot = UInt(sqrt(Double(self)))
        if squareRoot * squareRoot == self { return (false, squareRoot) }
        for i in 2..<UInt(ceil(Double(squareRoot))) where self % i == 0 {
            return (false, i)
        }
        return retVal
    }
}

func printd(str: String) {
    #if DEBUG
        print(str)
    #endif
}
func printd(num: Int) {
    #if DEBUG
        print(num)
    #endif
}

func printInput(numCases: Int, inputs: [(length: Int, numJamRequested: Int)]) {
    printd(String(numCases))
    for input in inputs {
        printd(String(format: "%d %d", input.length, input.numJamRequested))
    }
}

func printOutput(numCases: Int, solutions: [[[String:[UInt]]]]) {
    for i in 0..<numCases {
        print(String(format: "Case #%d:", i+1))

        for caseSolutions in solutions {
            for caseSolution in caseSolutions {
                for (coinJam, divisors) in caseSolution {
                    print("\(coinJam)", terminator: " ")
                    let str = divisors.reduce("") { "\($0) \($1)" }
                    print(str)
                }
            }
        }
    }
}

let numCases = Int(readLine() ?? "0") ?? 0
var caseData = [(length: Int, numJamRequested: Int)]()

for _ in 0..<numCases {
    let inputString = readLine() ?? "2 11"
    let caseDataStrings = inputString.componentsSeparatedByString(" ")
    caseData.append((Int(caseDataStrings[0]) ?? 2, Int(caseDataStrings[1]) ?? 11))
}
printInput(numCases, inputs: caseData)

var solutions = [[[String:[UInt]]]]()

for (i, caseI) in caseData.enumerate() {
    var caseSolutions = [[String:[UInt]]]()

    let numToInsert = caseI.length - 2 >= 2 ? caseI.length-2 : 0
    printd(numToInsert)

    for k in 0..<UInt(pow(2.0, Double(numToInsert))) {
        var caseSolution = [String:[UInt]]()
        var potentialJam = "11"
        var kStr = String(k, radix: 2)
        if kStr.characters.count < numToInsert {
            for _ in 0..<numToInsert-kStr.characters.count {
                kStr.insert("0", atIndex: kStr.startIndex)
            }
        }
        potentialJam.insertContentsOf(kStr.characters, at: kStr.startIndex.successor())

        var divisors = [UInt]()
        for l: Int32 in 2...10 {
            let potentialJamInt = strtoul(potentialJam, nil, l)
            let primeResults = UInt(potentialJamInt/2).isPrime
            if !primeResults.yes {
                divisors.append(primeResults.divisor)
            }
        }
        if divisors.count == 9 {
            caseSolution[potentialJam] = divisors
            caseSolutions.append(caseSolution)
            if caseSolutions.count == caseI.numJamRequested {
                solutions.append(caseSolutions)
                break
            }
        }
    }
}

printOutput(numCases, solutions: solutions)
