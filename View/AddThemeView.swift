import SwiftUI


struct AddThemeView: View {
    
    @Environment(\.presentationMode) var presentationMode

    var store: ThemeStore
    @State private var name: String = ""
    @State private var emojis: [String] = ["👽", "👾", "🤖"]
    @State private var numberOfPairs: Int = 2
    @State private var addEmoji: String = ""
    @State private var showAlert = false


    
    var body: some View {
        ZStack {
            Color(red: 233.0/255, green: 233.0/255, blue: 233.0/255).ignoresSafeArea()
            ThemeListView().vectorView
            Form {
                nameSection
                addEmojiSection
                emojisSection
                cardCountSection
            }
            .scrollContentBackground(.hidden)
            .scrollContentBackground(.visible)
            .onAppear() {
            }
            .navigationBarItems(
                leading: Button(action: {cancel()}, label: { Text("Cancel") }),
                trailing: Button(action: create, label: { Text("Done") })
                    .disabled(cannotSave())
            )
            .navigationBarBackButtonHidden()
            .navigationTitle("Add New Theme")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Missing field"), message: Text("You need to fill name or emoji field. "), dismissButton: .cancel())
            }
        }
    }
    var nameSection: some View {
        Section(header: Text("Theme name").font(.headline)) {
            
            TextField("Enter theme name", text: $name)
        }
    }
    
    var addEmojiSection: some View {
        Section(header: Text("Add Emoji").font(.headline)) { 
            HStack {
                TextField("Enter emoji", text: $addEmoji)
                
                Button {
                    let newEmoji = addEmoji.trimmingCharacters(in: .whitespacesAndNewlines)
                    emojis.insert(contentsOf: Set<String>(newEmoji.map{String($0)}), at: 0)
                    addEmoji = ""
                } label: {
                    Text("Add")
                }
            }
        }
    }
    
    var emojisSection: some View {
        Section(header: HStack {
            Text("Emojis").font(.headline)
            Spacer()
            Text("tap emoji to exclude")
        }) {
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 30))], spacing: 10) {
                    ForEach(emojis, id: \.self) { emoji in
                        Text(emoji).font(.title)
                            .onTapGesture {
                                emojis.removeAll(where: { $0 == emoji })
                        } 
                    }
                }
            }
        }
    }
    
    var cardCountSection: some View {
        Section(header: Text("Card Count").font(.headline)) {
            Stepper("\(numberOfPairs) pairs", value: $numberOfPairs, in: min(emojis.count, 2)...emojis.count)
                .disabled(emojis.count < 2)
        }
    }
    
  func create() {
      if name != "" && !emojis.isEmpty {
              let newTheme: Theme = Theme(name: name, emojis: emojis, numberOfCards: numberOfPairs)
              store.addTheme(theme: newTheme)
              
              
              presentationMode.wrappedValue.dismiss()
          } else {
              showAlert = true
          }

    }
    
    func cancel() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func cannotSave() -> Bool {
        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && emojis.count < 2
    }

}

