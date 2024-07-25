//
//  TypeNumber.swift
//  CarReader
//
//  Created by Тимофій Безверхий on 11.07.2024.
//

import SwiftUI

struct TypeNumber: View {
    @State private var number : String = ""
    @State private var showCarInfo = false
    @State private var isAlert = false
    @State private var cData : [String:String] = [:]
    @State private var bgColor = Color.blue
    @State private var errorMessage : String!
    @State private var isNumberEntered = false
    @EnvironmentObject var carHistoryManager: CarHistoryFileManager
    
    var body: some View {
        if (showCarInfo){
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
                    
                    TextField("Введіть", text: $number)
                        .textFieldStyle(.plain)
                        .foregroundStyle(Color.white)
                        .padding(8)
                        .background(bgColor)
                        .cornerRadius(10)
                        .autocorrectionDisabled()
                        .padding([.bottom,.leading,.trailing])
                        .textInputAutocapitalization(.characters)
                        .onSubmit() {
                            if NumberCheck(inputStr: number){
                                isNumberEntered = true
                            }
                            else {
                                errorMessage = "Некоректний номер"
                                bgColor = Color.red
                                isAlert = true
                            }
                        }
                    if isNumberEntered{
                        if cData.isEmpty {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(2.0)
                                .frame(minWidth: 100,idealWidth: .infinity, minHeight: 100, idealHeight: 150)
                                .onAppear{
                                    Task{
                                        self.cData = try await getNumberFromCloud(name: number)
                                    }
                                }
                        }
                        else {
                            if let possibleError = cData["Error"]{
                                Text("")
                                    .onAppear{
                                        errorMessage = possibleError == "1" ? "Ключа не знайдено" :
                                        (possibleError == "404" ? "Помилка зʼєднання з сервером" :
                                            "Виникла невідома помилка")
                                        withAnimation(.easeInOut(duration:1.0)){
                                            bgColor = Color.red
                                        }
                                        isAlert = true
                                    }
                                    
                            } else {
                                ProgressView("Завантаження...")
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .foregroundColor(.white)
                                    .onAppear {
                                        showCarInfo = true
                                    }
                            }
                        }
                    }
                    Spacer()
                } // VStack
                .alert("Помилка", isPresented: $isAlert, actions: {
                    Button("OK", role: .cancel) {
                        self.number = ""
                        withAnimation(.easeInOut(duration: 1.0)){
                            bgColor = Color.blue
                        }
                        self.cData = [:]
                    }
                }, message: {
                    Text(errorMessage ?? "Невідома помилка")
                })

            } // ZStack
        }
    } // body
} // struct

#Preview {
    TypeNumber()
}
