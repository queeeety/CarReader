//
//  TableHandler.swift
//  CarReader
//
//  Created by Тимофій Безверхий on 11.07.2024.
//

import Foundation
import SwiftCSV


import SwiftCSV
import Foundation



func convertLatinToCyrillic(_ latinString: String) -> String {
    let latinToCyrillic: [Character: Character] = [
        "A": "А", // Latin 'A' to Cyrillic 'A'
        "B": "В", // Latin 'B' to Cyrillic 'B'
        "E": "Е", // Latin 'E' to Cyrillic 'E'
        "K": "К", // Latin 'K' to Cyrillic 'K'
        "M": "М", // Latin 'M' to Cyrillic 'M'
        "H": "Н", // Latin 'H' to Cyrillic 'Н'
        "O": "О", // Latin 'O' to Cyrillic 'О'
        "P": "Р", // Latin 'P' to Cyrillic 'Р'
        "C": "С", // Latin 'C' to Cyrillic 'С'
        "T": "Т", // Latin 'T' to Cyrillic 'Т'
        "Y": "У", // Latin 'Y' to Cyrillic 'У'
        "X": "Х", // Latin 'X' to Cyrillic 'Х'
        "I": "І", // Latin 'I' to Cyrillic 'І'
    ]
    return String(latinString.map { latinToCyrillic[$0] ?? $0 })
}
func NumbersCheck (num: String) -> [String:String]
{
    
    var CyrNum = convertLatinToCyrillic(num)
    CyrNum = CyrNum.replacingOccurrences(of: " ", with: "")
    let fileName = "trialFile"
    let data : [[String:String]]
    let keyOrder = ["N_REG_NEW", "REG_ADDR_KOATUU", "OPER_CODE", "OPER_NAME","D_REG", "DEP_CODE", "DEP", "BRAND", "MODEL", "VIN", "MAKE_YEAR", "COLOR", "KIND", "BODY", "PURPOSE", "FUEL", "CAPACITY", "OWN_WEIGHT", "TOTAL_WEIGHT"]
    
    guard let filePath = Bundle.main.path(forResource: fileName, ofType: "csv") else {
        print("File not found")
        return ["1":"File not found"]
    }

    do {
        let csv = try CSV<Named>(url: URL(fileURLWithPath: filePath))
        data = csv.rows
    } catch {
        print("Error reading CSV file: \(error)")
        return ["1":"Error reading CSV file: \(error)"]
    }
    
    for element in data {
        if let unwrapNum = element["N_REG_NEW"]{
            
            if unwrapNum == CyrNum || unwrapNum == num {
//                let valuesString = keyOrder.compactMap { element[$0] }
                return element
            }
        }
    }
    return ["1":"NoElement"]
    
}

func NumberCheck (inputStr: String) -> Bool{
    let str = inputStr.replacingOccurrences(of: " ", with: "")
    if (str.count == 8
        && str.prefix(2).allSatisfy({$0.isLetter})
        && str.suffix(2).allSatisfy({$0.isLetter})
        && str.dropFirst(2).prefix(4).allSatisfy({$0.isNumber})
    ){
        return true
    }
    else{
        return false
    }
    
}

