//
//  FileWork.swift
//  CarReader
//
//  Created by Тимофій Безверхий on 13.07.2024.
//

import Foundation

struct Car: Codable {
    var REG_ADDR_KOATUU : String
    var person: String
    var operCode: String
    var operName: String
    var regDate: String
    var depCode: String
    var dep: String
    var brand: String
    var model: String
    var vin: String
    var year: String
    var color: String
    var kind: String
    var body: String
    var purpose: String
    var fuel: String
    var capacity: String
    var ownWeight: String
    var totalWeight: String
    var regNumber: String
    // Add other properties as needed
    
    init(dict: [String:String]) {
        self.REG_ADDR_KOATUU = dict["REG_ADDR_KOATUU"] ?? ""
        self.person = dict["PERSON"] ?? ""
        self.operCode = dict["OPER_CODE"] ?? ""
        self.operName = dict["OPER_NAME"] ?? ""
        self.regDate = dict["D_REG"] ?? ""
        self.depCode = dict["DEP_CODE"] ?? ""
        self.dep = dict["DEP"] ?? ""
        self.brand = dict["BRAND"] ?? ""
        self.model = dict["MODEL"] ?? ""
        self.vin = dict["VIN"] ?? ""
        self.year = dict["MAKE_YEAR"] ?? ""
        self.color = dict["COLOR"] ?? ""
        self.kind = dict["KIND"] ?? ""
        self.body = dict["BODY"] ?? ""
        self.purpose = dict["PURPOSE"] ?? ""
        self.fuel = dict["FUEL"] ?? ""
        self.capacity = dict["CAPACITY"] ?? ""
        self.ownWeight = dict["OWN_WEIGHT"] ?? ""
        self.totalWeight = dict["TOTAL_WEIGHT"] ?? ""
        self.regNumber = dict["N_REG_NEW"] ?? ""
    }
}

class CarHistoryFileManager {
    private let fileManager = FileManager.default
    private let fileName = "CarHistory.json"
    
    private var fileURL: URL {
        fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
    }
    
    func saveCar(_ car: Car) {
        var history = loadHistory()
        history.append(car)
        if let encoded = try? JSONEncoder().encode(history) {
            try? encoded.write(to: fileURL)
        }
    }
    
    func loadHistory() -> [Car] {
        if let data = try? Data(contentsOf: fileURL),
           let decoded = try? JSONDecoder().decode([Car].self, from: data) {
            return decoded
        }
        return []
    }
}
