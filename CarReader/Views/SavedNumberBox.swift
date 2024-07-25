//
//  SavedNumberBox.swift
//  CarReader
//
//  Created by Тимофій Безверхий on 11.07.2024.
//

import SwiftUI

struct SavedNumberBox: View {
    let car: Car

    var body: some View {
        NavigationLink(destination: infoPage(car: car), label: {
            HStack{
                VStack(alignment: .leading){
                    Text(car.regNumber)
                        .font(.system(size: 30, weight: .bold, design: .default))
                        .padding(.top, 10)
                        .padding(.bottom,5)
                        .foregroundStyle(Color(.white))
                    
                    Text(car.brand + " " + car.model)
                        .font(.system(size: 25, weight: .bold, design: .default))
                        .padding(.bottom, 10)
                        .foregroundStyle(Color(.white))
                }
                .padding()
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 100)
            .background(Color.blue.opacity(0.4))
            .clipShape(.rect(cornerRadius: 20))
            .padding([.top, .leading,.trailing],10)
        })
    }
}

#Preview {
    SavedNumberBox(car: testCar)
}
