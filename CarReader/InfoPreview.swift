//
//  infoPage.swift
//  CarReader
//
//  Created by Тимофій Безверхий on 13.07.2024.
//

import SwiftUI

struct infoPage: View {
 @State var info: [String:String] = ["MODEL": " ", //+
                                    "OWN_WEIGHT": " ", //
                                    "COLOR": " ", //
                                    "BODY": " ", //
                                    "BRAND": " ",//
                                    "KIND": " ", //
                                    "TOTAL_WEIGHT": " ", //
                                    "N_REG_NEW": " ", //
                                    "DEP_CODE": " ", //
                                    "VIN": " ", //
                                    "REG_ADDR_KOATUU": " ",
                                    "FUEL": " ", //
                                    "PURPOSE": " ", //
                                    "PERSON": " ", //
                                    "DEP": " ", //
                                    "D_REG": " ", //
                                    "CAPACITY": " ", //
                                    "MAKE_YEAR": " ", //
                                    "OPER_CODE": " ",
                                    "OPER_NAME": " "]
    @State var car: Car
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
                    Text(car.brand + " " + car.model)
                        .font(.title)
                        .bold()
                    Text(car.year + " року")
                        .font(.title)
                    ScrollView{
                        HStack{
                            SingleParameterView(iconName: "b.circle", parName: "Бренд", parValue:car.brand)
                            SingleParameterView(iconName: "m.circle", parName: "Модель", parValue:car.model)
                        }
                        HStack{
                            SingleParameterView(iconName: "car.fill", parName: "Тип", parValue:car.kind)
                            SingleParameterView(iconName: "car.rear.fill", parName: "Тип кузову", parValue:car.body)
                            
                        }
                        SingleParameterView(iconName: "engine.combustion", parName: "VIN номер", parValue:car.vin)
                        HStack{
                            SingleParameterView(iconName: "calendar", parName: "Рік випуску", parValue:car.year)
                            SingleParameterView(iconName: "calendar", parName: "Дата реєстрації", parValue:car.regDate)
                        }
                        HStack{
                            SingleParameterView(iconName: "calendar", parName: "Номер", parValue:car.regNumber)
                            SingleParameterView(iconName: "person.circle", parName: "Власник", parValue:(
                                (car.person == "P" ? "Фіз. особа" : car.person)))
                        }
                        HStack {
                            SingleParameterView(iconName: "paintbrush.fill", parName: "Колір", parValue:car.color)
                            
                            SingleParameterView(iconName: "questionmark.circle", parName: "Призначення", parValue:car.purpose)
                        }
                        HStack {
                            SingleParameterView(iconName: "gauge.with.dots.needle.bottom.0percent", parName: "Власна вага", parValue:car.ownWeight + " кг")
                            
                            SingleParameterView(iconName: "gauge.with.dots.needle.bottom.100percent", parName: "Максимальна вага", parValue:car.totalWeight + " кг")
                        }
                        
                        HStack{
                            SingleParameterView(iconName: "fuelpump.fill", parName: "Паливо", parValue:car.fuel)
                            
                            SingleParameterView(iconName: "engine.combustion", parName: "Обʼєм двигуна", parValue:car.capacity)
                        }
                        HStack{
                            SingleParameterView(iconName: "barcode.viewfinder", parName: "Код відділення", parValue:car.depCode)
                            
                            SingleParameterView(iconName: "building.columns.circle", parName: "Відділення", parValue:car.dep)
                        }
                        HStack{
                            SingleParameterView(iconName: "barcode.viewfinder", parName: "Код операції", parValue:car.operCode)
                            
                            SingleParameterView(iconName: "building.columns.circle", parName: "REG_ADDR_KOATUU", parValue:car.REG_ADDR_KOATUU)
                        }
                        SingleParameterView(iconName: "building.columns.circle", parName: "Назва операції", parValue:car.operName)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .ignoresSafeArea(.all)
                }
            }
    }
}

#Preview {
    infoPage(car: Car(dict: ["MODEL": "GOLF", //+
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
                    "OPER_NAME": "ПЕРЕРЕЄСТРАЦІЯ ТЗ НА НОВ. ВЛАСН. ПО ДОГОВОРУ УКЛАДЕНОМУ В ТСЦ"]))
}
