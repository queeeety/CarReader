//
//  TypeNumber.swift
//  CarReader
//
//  Created by Тимофій Безверхий on 11.07.2024.
//

import SwiftUI

struct TypeNumber: View {
    @State private var number = ""
    @State private var isSubmitted = false
    @State private var isAlert = false
    @State private var cData : [String:String] = [:]
    @State private var bgColor = Color.blue
    @EnvironmentObject var carHistoryManager: CarHistoryFileManager
    
    var body: some View {
        if (isSubmitted){
            let car = Car(dict: cData)
            infoPage(car: car)
                .onAppear{carHistoryManager.saveCar(car)}
        }
        else{
            ZStack{
                RadialGradient(
                    colors: [bgColor, .white],
                    center: .topLeading,
                    startRadius: 0,
                    endRadius: screenSize.width*2)
                .edgesIgnoringSafeArea(.all)
                VStack{
                    Text("Пошук")
                        .bold()
                        .font(.system(size: 34, weight: .bold, design: .default))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color(.white))
                    
                    TextField("Enter", text: $number)
                        .textFieldStyle(.plain)
                        .foregroundStyle(Color.white)
                        .padding(8)
                        .background(bgColor)
                        .cornerRadius(10)
                        .onSubmit() {
                            if NumberCheck(inputStr: number){
                                
                                cData = NumbersCheck(num: number)
                                if cData.count == 1{
                                    bgColor = Color.red
                                    isAlert = true
                                }
                                else{
                                    isSubmitted = true
                                }
                            }
                            else
                            {
                                bgColor = Color.red
                                isAlert = true
                                number = ""
                            }
                        }
                        .padding([.bottom,.leading,.trailing])
                        .textInputAutocapitalization(.characters)
                        .alert("Помилка", isPresented: $isAlert, actions: {
                            Button("OK", role: .cancel) {
                                self.number = ""
                                bgColor = Color.blue
                            }
                        }, message: {
                            Text("Номеру не знайдено")
                        })
                    Spacer()
                    
                }
            }
        }
    }
}

#Preview {
    TypeNumber()
}
