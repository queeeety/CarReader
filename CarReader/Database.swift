import SwiftUI
import Firebase
import FirebaseFirestore
import SwiftCSV

public func getNumberFromCloud(name: String /*,status: Binding<Bool>*/) async throws -> [String: String] {
//    defer { status.wrappedValue = false }
    let db = Firestore.firestore()
    let cyrName = convertLatinToCyrillic(name)
    // Отримання документа за допомогою async/await
    let document = try await db.collection("plates").document(cyrName).getDocument()

    if document.exists {
        return convertDictionaryToStringDictionary(input: document.data() ?? ["Error": "1"])
    } else {
        return ["Error": "1"]
    }
}


func convertDictionaryToStringDictionary(input: [String: Any]) -> [String: String] {
    var result = [String: String]()
    
    for (key, value) in input {
        // Спробуйте перетворити значення на рядок
        if let stringValue = value as? String {
            result[key] = stringValue
        } else {
            // Перетворення інших типів на рядок
            result[key] = "\(value)"
        }
    }
    
    return result
}



struct DataBaseFiller: View {
    @State private var isUploading = false
    @State private var progress: Double = 0.0
    let db = Firestore.firestore()

    var body: some View {
        VStack {
            if isUploading {
                ProgressView(value: progress, total: 1.0)
                    .progressViewStyle(LinearProgressViewStyle())
                    .padding()
                Text("Uploading: \(Int(progress * 100))%")
            } else {
                Button("Upload CSV to Firestore") {
                    if let filePath = Bundle.main.path(forResource: "file2024", ofType: "csv") {
                        fillFirestoreFromCSV(filePath: filePath, collectionName: "plates")
                        print("Func ended")
                    } else {
                        print("CSV file not found in bundle2")
                    }
                }
                .padding()
            }
        }
    }
    
    func fillFirestoreFromCSV(filePath: String, collectionName: String) {
        isUploading = true
        isUploading = true
        DispatchQueue.global(qos: .background).async {
            do{
                let fileContents = try String(contentsOfFile: filePath)
                let csv = try CSV<Named>(string: fileContents)
                let totalRows = csv.rows.count
                var currentRow = 0
                print ("Process started. the vars were created")
                for row in csv.rows {
                    var documentData: [String: Any] = [:]
                    
                    for (key, value) in row {
                        documentData[key] = value
                        
                    }
                    print("\(currentRow+1) was read")
                    if (documentData["N_REG_NEW"] as! String == ""){
                        print ("Empty number. skip")
                        currentRow += 1
                        continue
                        
                    }
                    
                    db.collection(collectionName)
                        .document(documentData["N_REG_NEW"] as? String ?? "?")
                        .setData(documentData) { err in
                            if let err = err {
                                print("Error adding document: \(err)")
                            }
                            
                        }
                    print("Done adding")
                    
                    currentRow += 1
                    let progressValue = Double(currentRow) / Double(totalRows)
                    DispatchQueue.main.async {
                        progress = progressValue
                    }
                    
                }
                print("end of the function")
                isUploading = false
            } catch {
                print("Error processing CSV file: \(error)")
                DispatchQueue.main.async {
                    isUploading = false
                }
            }
        }
    }
}

#Preview {
    DataBaseFiller()
 }


