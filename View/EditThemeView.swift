import SwiftUI


struct EditThemeView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var store: ThemeStore
    @State var theme: Theme
    @State private var name: String = ""
    @State private var emojis: [String] = ["b", "c", "k", "o", "d","w", "v", "q", "r", "m", "a"]
    @State private var numberOfPairs: Int = 2
    @State private var addEmoji: String = ""
    @State private var showAlert = false
    
    
    
    var body: some View {
        NavigationStack {
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
                    name = theme.name
                    emojis = theme.emojis
                    numberOfPairs = theme.numberOfCards
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Missing field"), message: Text("You need to fill name or emoji field. Also check your pair count"), dismissButton: .cancel())
                }
            }
            .navigationTitle("Edit Theme")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        cancel()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Update") {
                        update()
                    }
                    .disabled(cannotSave())
                }
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
    
  func update() {
      if name != "" && !(emojis.count < numberOfPairs) {
            theme.emojis = emojis
            theme.name = name
            theme.numberOfCards = numberOfPairs
            
            if let index = store.themeList.firstIndex(where: { $0.id == theme.id }) {
                store.themeList[index] = theme
            }
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

