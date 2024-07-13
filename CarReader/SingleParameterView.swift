//
//  SingleParameterView.swift
//  CarReader
//
//  Created by Тимофій Безверхий on 13.07.2024.
//

import SwiftUI

struct SingleParameterView: View {
    let iconName : String
    let parName : String
    let parValue : String
    let minSize = CGFloat(100)
    let idealSize = CGFloat(150)
    let maxSize = CGFloat(170)
    
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .foregroundStyle(Material.ultraThinMaterial)
                .background(.blue.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))

            VStack(alignment:.center){
                HStack{
                    Image(systemName:iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: minSize/3, idealWidth: idealSize/3, maxWidth: maxSize/3, minHeight: minSize/3, idealHeight: idealSize/3, maxHeight: maxSize/3)
                        .foregroundStyle(Color.white.opacity(0.7))
                    Text(parName)
                        .foregroundStyle(Color.white.opacity(0.7))
                        .font(.title3)                    
                        .minimumScaleFactor(0.5)
                    Spacer()
                }
                .padding([.leading], 5)
                Text(parValue)
                    .font(.largeTitle)
                    .padding([.bottom, .top])
                    .padding([.trailing, .leading], 10)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.5)
            }
            .padding([.top,.bottom, .all], 5)
            
        }
        .frame(minWidth: minSize, idealWidth: idealSize, maxWidth: .greatestFiniteMagnitude, minHeight: minSize, idealHeight: idealSize, maxHeight: maxSize, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .padding(5)
    }
}
#Preview {
    SingleParameterView(iconName: "b.circle", parName: "модель", parValue: "ПЕРЕРЕЄСТРАЦІЯ ТЗ НА НОВ. ВЛАСН. ПО ДОГОВОРУ УКЛАДЕНОМУ В ТСЦ")
}
