import SwiftUI

struct CarRecord: Identifiable {
    var id = UUID()
    var number: String
    var model: String
}

struct Trial: View {
    @State private var carRecords = [
        CarRecord(number: "AI9119CO", model: "MERCEDES-BENZ SPRINTER"),
        CarRecord(number: "AI0198OP", model: "KIA CERATO"),
        CarRecord(number: "AI5856OI", model: "TOYOTA CAMRY")
    ]
    
    var body: some View {
        ZStack {
            RadialGradient(
                colors: [.blue, .white],
                center: .topLeading,
                startRadius: 0,
                endRadius: UIScreen.main.bounds.width * 2)
            .edgesIgnoringSafeArea(.all)
            List {
                ForEach(carRecords) { record in
                    VStack(alignment: .leading) {
                        Text(record.number)
                            .font(.headline)
                        Text(record.model)
                            .font(.subheadline)
                    }
                    .padding()

                }
                .onDelete(perform: deleteRecord)
            }
            .listStyle(.grouped)
            .background(.ultraThinMaterial)

        }
    }
    
    private func deleteRecord(at offsets: IndexSet) {
        carRecords.remove(atOffsets: offsets)
    }
}

#Preview{
    Trial()
}
