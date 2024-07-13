//
//  SavedNumberBox.swift
//  CarReader
//
//  Created by Тимофій Безверхий on 11.07.2024.
//

import SwiftUI

struct SavedNumberBox: View {

    let number: String
    let carName:String
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(number)
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .padding(.top, 10)
                    .padding(.bottom,5)
                    .foregroundStyle(Color(.white))

                Text(carName)
                    .font(.system(size: 25, weight: .bold, design: .default))
                    .padding(.bottom, 10)
                    .foregroundStyle(Color(.white))
            }
            .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 60)
        .padding(.vertical, 30)
        .background(Color.blue.opacity(0.4))
        .clipShape(.rect(cornerRadius: 20))
        .padding(10)
    }
}

#Preview {
    SavedNumberBox(number: "AX 2020 BX", carName: "Лада калина")
}
