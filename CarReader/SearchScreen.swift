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

    
    var body: some View {
        if showCarInfo
        {
            infoPage(info: cData)
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
                            ProgressView("Завантаження...")
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .foregroundColor(.white)
                                .onAppear {
                                    self.cData = NumbersCheck(num: recognizedText)
                                }
                            if cData.count <= 1 {
                                Text("No Element Found")
                                    .alert("Помилка", isPresented: $showingAlert, actions: {
                                        Button("OK", role: .cancel) {
                                            self.recognizedText = nil
                                            bgColor = Color.blue
                                        }
                                    }, message: {
                                        Text("Номеру не знайдено")
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
                        } else {
                            CameraView(recognizedText: $recognizedText)
                                .edgesIgnoringSafeArea(.all)
                        }
                    }
                    
                    .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                    .padding([.leading,.trailing,.bottom],10)
                    
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
