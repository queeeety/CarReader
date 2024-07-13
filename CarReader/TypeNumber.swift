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
    var body: some View {
        ZStack{
            RadialGradient(
                colors: [.blue, .white],
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
                    .background(.blue)
                    .cornerRadius(10)
                    .onSubmit() {
                        isSubmitted = true
                    }
                    .padding([.bottom,.leading,.trailing])
                    .textInputAutocapitalization(.characters)
                
                Spacer()
                
                if (isSubmitted){
                    NavigationLink(destination:SearchScreen()) {
                        ZStack(alignment: .center) {
                            Rectangle()
                                .frame(maxHeight: 100)
                                .foregroundStyle(Color.clear)
                                .blur(radius: /*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                            
                            RoundedRectangle(cornerRadius: 190)
                                .frame(maxHeight: 80)
                                .padding(10)
                                .foregroundColor(.blue)
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
                    .frame(alignment: .bottom)
                }
            }
            
            
        }
    }
    
}

#Preview {
    TypeNumber()
}
