import SwiftUI
import SwiftCSV
struct ContentView: View {

    var body: some View {
        NavigationView(content: {
            ZStack{
                RadialGradient(
                    colors: [.blue, .white],
                    center: .topLeading,
                    startRadius: 0,
                    endRadius: screenSize.width*2)
                .edgesIgnoringSafeArea(.all)
                
                VStack{
                    Text(Greetings())
                        .bold()
                        .font(.system(size: 34, weight: .bold, design: .default))
                        .multilineTextAlignment(.center)
                        .padding(.top,30)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color(.white))
                    Spacer(minLength: 20)
                    
                    Text("Нещодавні")
                        .bold()
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .multilineTextAlignment(.center)
                        .padding(.top,30)
                        .foregroundStyle(Color(.white))
                    
                    ZStack{
                        VStack{
                            ScrollView{
                                SavedNumberBox(number: "AX 2020 AX", carName: "Машинка 1")
                                SavedNumberBox(number: "AX 2020 AX", carName: "Машинка 1")
                                SavedNumberBox(number: "AX 2020 AX", carName: "Машинка 1")
                                SavedNumberBox(number: "AX 2020 AX", carName: "Машинка 1")
                                SavedNumberBox(number: "AX 2020 AX", carName: "Машинка 1")
                            }
                        }
                        
                        VStack{
                            Spacer()
                            
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
                                        Image(systemName: "magnifyingglass")
                                            .foregroundColor(.white)
                                            .font(.system(size: 24, weight: .bold))
                                        
                                        Text("Шукати")
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
        })
    }
}

#Preview {
    ContentView()
}
