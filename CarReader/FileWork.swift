//
//  FileWork.swift
//  CarReader
//
//  Created by Тимофій Безверхий on 13.07.2024.
//

import Foundation

struct Car: Codable, Hashable {
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

import Foundation
import Combine

class CarHistoryFileManager: ObservableObject {
    @Published var carHistory: [Car] = []
    
    private let fileManager = FileManager.default
    private let fileName = "CarHistory.json"
    
    private var fileURL: URL {
        fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
    }
    
    init() {
        loadHistory()
    }
    
    func saveCar(_ car: Car) {

        if carHistory.first != car{
            carHistory.insert(car, at: 0) // Insert the new car at the beginning of the array
        }
        if let encoded = try? JSONEncoder().encode(carHistory) {
            try? encoded.write(to: fileURL)
        }
    }
    
    func loadHistory() {
        if let data = try? Data(contentsOf: fileURL),
           let decoded = try? JSONDecoder().decode([Car].self, from: data) {
            carHistory = decoded
        }
    }
    func clearHistory() {
        carHistory.removeAll() // Clear the in-memory history
        if let encoded = try? JSONEncoder().encode(carHistory) {
            try? encoded.write(to: fileURL) // Write the empty array to the file
        }
    }
}
let testCar = Car(dict: ["MODEL": "GOLF", //+
                         "OWN_WEIGHT": "1020", //
                         "COLOR": "БІЛИЙ", //
                         "BODY": "ХЕТЧБЕК", //
                         "BRAND": "VOLKSWAGEN",//
                         "KIND": "ЛЕГКОВИЙ", //
                         "TOTAL_WEIGHT": "1850", //
                         "N_REG_NEW": "АІ2805ОН", //
                         "DEP_CODE": "12286", //
                         "VIN": "WVWZZZ1KZCW268678", //
                         "REG_ADDR_KOATUU": "5610700000",
                         "FUEL": "БЕНЗИН", //
                         "PURPOSE": "ЗАГАЛЬНИЙ", //
                         "PERSON": "P", //
                         "DEP": "ТСЦ 3247", //
                         "D_REG": "09.12.2022", //
                         "CAPACITY": "1390", //
                         "MAKE_YEAR": "2012", //
                         "OPER_CODE": "315",
                         "OPER_NAME": "ПЕРЕРЕЄСТРАЦІЯ ТЗ НА НОВ. ВЛАСН. ПО ДОГОВОРУ УКЛАДЕНОМУ В ТСЦ"])
