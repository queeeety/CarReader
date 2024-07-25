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
    @State private var isLoading = true
    @State private var bgColor = Color.blue
    @EnvironmentObject var carHistoryManager: CarHistoryFileManager
    
    var body: some View {
        if showCarInfo
        {
            let car = Car(dict:cData)
            infoPage(car:car)
                .onAppear{carHistoryManager.saveCar(car)}
        }
        else if showNumbers {
            TypeNumber()
        }
        else{
            ZStack {
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
                    
                    Text("Наведіть камеру на номерний знак")
                        .bold()
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .multilineTextAlignment(.center)
                        .padding(.bottom,30)
                        .padding([.leading,.trailing],50)
                        .foregroundStyle(Color(.white))
                    Spacer()
                    VStack {
                        if let recognizedText = recognizedText {
                            
                            if cData.isEmpty {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(2.0)
                                    .frame(minWidth: 100,idealWidth: .infinity, minHeight: 100, idealHeight: 150)
                                    .onAppear{
                                        Task{
                                            self.cData = try await getNumberFromCloud(name: recognizedText, status: $isLoading)
                                        }
                                    }
                            }
                            else {
                                if let possibleError = cData["Error"]{
                                    
                                    let errorMessage = possibleError == "1" ? "Ключа не знайдено" :
                                    (possibleError == "404" ? "Помилка зʼєднання з сервером" :
                                        "Виникла невідома помилка")
                                    Text("!")
                                        .alert("Помилка", isPresented: $showingAlert, actions: {
                                            Button("OK", role: .cancel) {
                                                self.recognizedText = nil
                                                bgColor = Color.blue
                                                self.cData = [:]

                                            }
                                        }, message: {
                                            Text(errorMessage)
                                        })
                                        .onAppear {
                                            bgColor = Color.red
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

                    .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                    .padding([.leading,.trailing,.bottom],10)
                    Spacer()

                    Button{
                        showNumbers = true
                    }label: {
                        ZStack(alignment: .center) {
                            Rectangle()
                                .frame(maxHeight: 100)
                                .foregroundStyle(Color.clear)
                                .blur(radius: /*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                            
                            RoundedRectangle(cornerRadius: 190)
                                .frame(maxHeight: 80)
                                .padding(10)
                                .foregroundColor(bgColor)
                            HStack{
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
    }
}


#Preview {
    SearchScreen()
}
