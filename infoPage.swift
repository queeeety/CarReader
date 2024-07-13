//
//  infoPage.swift
//  CarReader
//
//  Created by Тимофій Безверхий on 13.07.2024.
//

import SwiftUI

struct infoPage2: View {
 @State var info: [String:String]
        let UEInp = "?"
        var body: some View {
            ZStack {
                RadialGradient(
                    colors: [.blue, .white],
                    center: .topLeading,
                    startRadius: 0,
                    endRadius: screenSize.width*2)
                .edgesIgnoringSafeArea(.all)
                VStack(alignment: .center){
                    Text((info["BRAND"] ?? UEInp) + " " + (info["MODEL"] ?? UEInp))
                        .font(.title)
                        .bold()
                    Text((info["MAKE_YEAR"] ?? UEInp) + " року")
                        .font(.title)
                    ScrollView{
                        HStack{
                            SingleParameterView(iconName: "b.circle", parName: "Бренд", parValue:(info["BRAND"] ?? UEInp))
                            SingleParameterView(iconName: "m.circle", parName: "Модель", parValue:(info["MODEL"] ?? UEInp))
                        }
                        HStack{
                            SingleParameterView(iconName: "car.fill", parName: "Тип", parValue:(info["KIND"] ?? UEInp))
                            SingleParameterView(iconName: "car.rear.fill", parName: "Тип кузову", parValue:(info["BODY"] ?? UEInp))
                            
                        }
                        SingleParameterView(iconName: "engine.combustion", parName: "VIN номер", parValue:(info["VIN"] ?? UEInp))
                        HStack{
                            SingleParameterView(iconName: "calendar", parName: "Рік випуску", parValue:(info["MAKE_YEAR"] ?? UEInp))
                            SingleParameterView(iconName: "calendar", parName: "Дата реєстрації", parValue:(info["D_REG"] ?? UEInp))
                        }
                        HStack{
                            SingleParameterView(iconName: "calendar", parName: "Номер", parValue:(info["N_REG_NEW"] ?? UEInp))
                            SingleParameterView(iconName: "person.circle", parName: "Власник", parValue:(
                                (info["PERSON"] == "P" ? "Фіз. особа" : (info["PERSON"] ?? ""))))
                        }
                        HStack {
                            SingleParameterView(iconName: "paintbrush.fill", parName: "Колір", parValue:(info["COLOR"] ?? UEInp))
                            
                            SingleParameterView(iconName: "questionmark.circle", parName: "Призначення", parValue:(info["PURPOSE"] ?? UEInp))
                        }
                        HStack {
                            SingleParameterView(iconName: "gauge.with.dots.needle.bottom.0percent", parName: "Власна вага", parValue:(info["OWN_WEIGHT"] ?? UEInp) + " кг")
                            
                            SingleParameterView(iconName: "gauge.with.dots.needle.bottom.100percent", parName: "Максимальна вага", parValue:(info["TOTAL_WEIGHT"] ?? UEInp) + " кг")
                        }
                        
                        HStack{
                            SingleParameterView(iconName: "fuelpump.fill", parName: "Паливо", parValue:(info["FUEL"] ?? UEInp))
                            
                            SingleParameterView(iconName: "engine.combustion", parName: "Обʼєм двигуна", parValue:(info["CAPACITY"] ?? UEInp))
                        }
                        HStack{
                            SingleParameterView(iconName: "barcode.viewfinder", parName: "Код відділення", parValue:(info["DEP_CODE"] ?? UEInp))
                            
                            SingleParameterView(iconName: "building.columns.circle", parName: "Відділення", parValue:(info["DEP"] ?? UEInp))
                        }
                        HStack{
                            SingleParameterView(iconName: "barcode.viewfinder", parName: "Код операції", parValue:(info["OPER_CODE"] ?? UEInp))
                            
                            SingleParameterView(iconName: "building.columns.circle", parName: "REG_ADDR_KOATUU", parValue:(info["REG_ADDR_KOATUU"] ?? UEInp))
                        }
                        SingleParameterView(iconName: "building.columns.circle", parName: "Назва операції", parValue:(info["OPER_NAME"] ?? UEInp))
                        
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .ignoresSafeArea(.all)
                }
            }
    }
}

#Preview {
    infoPage(info: ["MODEL": "GOLF", //+
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
}
