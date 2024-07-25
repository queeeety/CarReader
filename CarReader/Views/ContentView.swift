import SwiftUI
import SwiftCSV
struct ContentView: View {
    @EnvironmentObject var carHistoryManager: CarHistoryFileManager
    
    var body: some View {
        NavigationView(content: {
            ZStack{
                RadialGradient(
                    colors: [.blue, .white],
                    center: .topLeading,
                    startRadius: 0,
                    endRadius: screenSize.width*2)
                .edgesIgnoringSafeArea(.all)
                ZStack {
                    ScrollView{
                        VStack{
                            HStack(alignment: .center){
                                let greet = Greetings()
                                Text(greet[0])
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundStyle(Color(.white))
                                
                                Image(systemName: greet[1])
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundStyle(Color(.white))
                                    .onAppear{carHistoryManager.loadHistory()}
                            }
                            .multilineTextAlignment(.center)
                            .padding(.top,30)
                            .frame(maxWidth: .infinity, maxHeight: 100)
                            
                            Spacer(minLength: 20)

                            if (carHistoryManager.carHistory.isEmpty){
                                Text("Історії ще нема")
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .font(.title3)
                                    .foregroundStyle(Color(.white))
                            }
                            else{
                                Text("Нещодавні")
                                    .font(.title2)
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .padding(.top,30)
                                    .foregroundStyle(Color(.white))
                                ForEach(carHistoryManager.carHistory, id: \.self){thiscar in
                                    SavedNumberBox(car: thiscar)
                                }
                                Button {
                                    carHistoryManager.clearHistory()
                                } label: {
                                    ZStack(alignment: .center) {
                                        
                                        RoundedRectangle(cornerRadius: 25)
                                            .frame(minHeight:60, maxHeight: 100)
                                            .padding(20)
                                            .foregroundStyle(Color.blue.opacity(0.4))
                                        HStack{
                                            Image(systemName: "delete.forward")
                                                .foregroundColor(.white)
                                                .font(.system(size: 24, weight: .bold))
                                            
                                            Text("Видалити історію")
                                                .bold()
                                                .font(.title)
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                                .padding(.bottom, 100)

                            }
                        }
                    }.frame(maxHeight: .infinity)
                    
                    VStack{
                        Spacer()
                        NavigationLink(destination:SearchScreen()){
                            ZStack(alignment: .center) {
                                Rectangle()
                                    .frame(maxHeight: 100)
                                    .foregroundStyle(Color.clear)
                                    .blur(radius: 3.0)
                                
                                RoundedRectangle(cornerRadius: 190)
                                    .frame(maxHeight: 80)
                                    .padding(10)
                                    .foregroundColor(.blue)
                                HStack{
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .bold()
                                    
                                    Text("Шукати")
                                        .font(.title)
                                        .bold()
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                }
            }
        })
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CarHistoryFileManager())
    }
}
