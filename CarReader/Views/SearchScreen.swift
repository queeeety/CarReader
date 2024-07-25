//
//  MainScreen.swift
//  CarReader
//
//  Created by Тимофій Безверхий on 10.07.2024.
//

import SwiftUI

struct SearchScreen: View {
    @State var recognizedText: String?
    @State private var cData: [String:String] = [:]
    @State private var showingAlert = false
    @State private var navigateToTheNextPage = false
    @State private var showCarInfo = false
    @State private var showNumbers = false
    @State private var bgColor = Color.blue
    @EnvironmentObject var carHistoryManager: CarHistoryFileManager
    
    var body: some View {
        ZStack {
            RadialGradient(
                colors: [bgColor, .white],
                center: .topLeading,
                startRadius: 0,
                endRadius: UIScreen.main.bounds.width * 2)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                if showCarInfo {
                    let car = Car(dict: cData)
                    infoPage(car: car)
                        .onAppear { carHistoryManager.saveCar(car) }
                        .transition(.move(edge: .trailing)) // Плавний перехід при показі/приховуванні
                } else if showNumbers {
                    TypeNumber()
                        .transition(.move(edge: .trailing))  // Плавний перехід при показі/приховуванні
                } else {
                    VStack {
                        Text("Пошук")
                            .bold()
                            .font(.system(size: 34, weight: .bold, design: .default))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                        
                        Text("Наведіть камеру на номерний знак")
                            .bold()
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 30)
                            .padding([.leading, .trailing], 50)
                            .foregroundColor(.white)
                        Spacer()
                        VStack {
                            if let recognizedText = recognizedText {
                                if cData.isEmpty {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                        .scaleEffect(2.0)
                                        .frame(minWidth: 100, idealWidth: .infinity, minHeight: 100, idealHeight: 150)
                                        .onAppear {
                                            Task {
                                                self.cData = try await getNumberFromCloud(name: recognizedText)
                                            }
                                        }
                                } else {
                                    if let possibleError = cData["Error"] {
                                        let errorMessage = possibleError == "1" ? "Ключа не знайдено" :
                                        (possibleError == "404" ? "Помилка зʼєднання з сервером" :
                                            "Виникла невідома помилка")
                                        Text("!")
                                            .alert("Помилка", isPresented: $showingAlert, actions: {
                                                Button("OK", role: .cancel) {
                                                    self.recognizedText = nil
                                                    withAnimation(.easeInOut(duration: 2.0)) {
                                                        bgColor = Color.blue
                                                    }
                                                    self.cData = [:]
                                                    
                                                }
                                            }, message: {
                                                Text(errorMessage)
                                            })
                                            .onAppear {
                                                withAnimation(.easeInOut(duration: 2.0)) {
                                                    bgColor = Color.red
                                                }
                                                showingAlert = true
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
                            } else {
                                CameraView(recognizedText: $recognizedText)
                                    .edgesIgnoringSafeArea(.all)
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        .padding([.leading, .trailing, .bottom], 10)
                        Spacer()
                        Button {
                            showNumbers = true
                        } label: {
                            ZStack(alignment: .center) {
                                Rectangle()
                                    .frame(maxHeight: 100)
                                    .foregroundStyle(Color.clear)
                                    .blur(radius: 3.0)
                                
                                RoundedRectangle(cornerRadius: 190)
                                    .frame(maxHeight: 80)
                                    .padding(10)
                                    .foregroundColor(bgColor)
                                HStack {
                                    Image(systemName: "keyboard")
                                        .foregroundColor(.white)
                                        .font(.system(size: 24, weight: .bold))
                                    
                                    Text("Ввести номер")
                                        .bold()
                                        .font(.system(size: 30, weight: .bold, design: .default))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                }
            }
        } // ZStack
        .animation(.easeInOut, value: showCarInfo)
        .animation(.easeInOut, value: showNumbers)
    }
}


#Preview {
    SearchScreen()
}
