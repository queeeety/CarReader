//
//  InfoPreview.swift
//  CarReader
//
//  Created by Тимофій Безверхий on 13.07.2024.
//

import SwiftUI

struct InfoPreview: View {
    
    @State var information: [String:String] = ["MODEL": "GOLF", "OWN_WEIGHT": "1020", "COLOR": "БІЛИЙ", "BODY": "ХЕТЧБЕК", "BRAND": "VOLKSWAGEN", "KIND": "ЛЕГКОВИЙ", "TOTAL_WEIGHT": "1850", "N_REG_NEW": "АІ2805ОН", "DEP_CODE": "12286", "VIN": "WVWZZZ1KZCW268678", "REG_ADDR_KOATUU": "5610700000", "FUEL": "БЕНЗИН", "PURPOSE": "ЗАГАЛЬНИЙ", "PERSON": "P", "DEP": "ТСЦ 3247", "D_REG": "09.12.2022", "CAPACITY": "1390", "MAKE_YEAR": "2012", "OPER_CODE": "315", "OPER_NAME": "ПЕРЕРЕЄСТРАЦІЯ ТЗ НА НОВ. ВЛАСН. ПО ДОГОВОРУ УКЛАДЕНОМУ В ТСЦ"]

    var body: some View {
        ZStack {
            RadialGradient(
                colors: [.blue, .white],
                center: .topLeading,
                startRadius: 0,
                endRadius: screenSize.width*2)
            .edgesIgnoringSafeArea(.all)
            
            VStack{
                Text((information["BRAND"] ?? "") + " " + (information["MODEL"] ?? ""))
                    .bold()
                    .font(.system(size: 28, weight: .bold, design: .default))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color(.white))
                Text((information["MAKE_YEAR"] ?? "") + " року")
                    .bold()
                    .font(.system(size: 28, weight: .bold, design: .default))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color(.white))
                Spacer()
//                ScrollView{
//
//                        HStack{
//                            SingleParameterView(iconName: "calendar", parName: "Рік випуску", parValue: (information["MAKE_YEAR"] ?? "?"))
//                        }
//
//                }
            }
        }
    }
}

#Preview {
    InfoPreview(information: ["MODEL": "GOLF", "OWN_WEIGHT": "1020", "COLOR": "БІЛИЙ", "BODY": "ХЕТЧБЕК", "BRAND": "VOLKSWAGEN", "KIND": "ЛЕГКОВИЙ", "TOTAL_WEIGHT": "1850", "N_REG_NEW": "АІ2805ОН", "DEP_CODE": "12286", "VIN": "WVWZZZ1KZCW268678", "REG_ADDR_KOATUU": "5610700000", "FUEL": "БЕНЗИН", "PURPOSE": "ЗАГАЛЬНИЙ", "PERSON": "P", "DEP": "ТСЦ 3247", "D_REG": "09.12.2022", "CAPACITY": "1390", "MAKE_YEAR": "2012", "OPER_CODE": "315", "OPER_NAME": "ПЕРЕРЕЄСТРАЦІЯ ТЗ НА НОВ. ВЛАСН. ПО ДОГОВОРУ УКЛАДЕНОМУ В ТСЦ"])
}


