import SwiftUI
import SwiftCSV

struct Trial: View {
    let iconName : String
    let parName : String
    let parValue : String
    let minSize = CGFloat(50)
    let idealSize = CGFloat(100)
    let maxSize = CGFloat(150)
    
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                
            VStack(alignment:.center){
                HStack{
                    Text(parName)
                        .foregroundStyle(Color.secondary)
                        .font(.callout)
                    Image(systemName:iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: minSize/3, idealWidth: idealSize/3, maxWidth: maxSize/3, minHeight: minSize/3, idealHeight: idealSize/3, maxHeight: maxSize/3)
                        .foregroundStyle(Color.blue)
                }
                Spacer()
                Text(parValue)
                    .font(.title2)
                    .frame(alignment: .top)
                
                Spacer()
            }
            .padding([.top,.bottom, .all], 6)
            
            
        }
        .background(.thinMaterial)
        .frame(minWidth: minSize, idealWidth: idealSize, maxWidth: maxSize, minHeight: minSize, idealHeight: idealSize, maxHeight: maxSize, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct NextPageView: View {
    var body: some View {
        Text("This is the next page")
    }
}

#Preview {
    Trial(iconName: "key", parName: "Ключик", parValue: "Присутній")
}
