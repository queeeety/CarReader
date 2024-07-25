import SwiftUI
import SwiftCSV
import UIKit


struct Trial: View {

    var body: some View {

            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(2.0)
                .foregroundStyle(.thinMaterial)
                .font(.largeTitle)
        
    }
}
#Preview {
    Trial()
}
