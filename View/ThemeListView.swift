import SwiftUI

struct ThemeListView: View {
    @ObservedObject var store = ThemeStore()
    @State private var selectedTheme: Theme?

    
    var body: some View {
        ZStack {
            Color(red: 233.0/255, green: 233.0/255, blue: 233.0/255).ignoresSafeArea()
            vectorView
            List() { 
                ForEach(store.themeList) { theme in
                    @ObservedObject var viewModel = EmojiMemoryGame(theme: theme)
                    ZStack {
                        NavigationLink(destination: EmojiMemoryGameView(viewModel: viewModel)){
                            EmojiThemeRow(theme: theme)
                        }
                    }.listRowBackground(LinearGradient(gradient: Gradient(colors: [Color(red: 83.0/255, green: 86.0/255, blue: 91.0/255), Color(red: 38.0/255, green: 45.0/255, blue: 61.0/255)]), startPoint: .top, endPoint: .bottom))
                        .swipeActions(edge: .leading) {
                            Button {
                                selectedTheme = theme
                            } label: {
                                Label("Edit", systemImage: "square.and.pencil.circle")
                            }
                            .tint(.blue)
                        }
                    
                }
                .onDelete(perform: { indexSet in
                    store.themeList.remove(atOffsets: indexSet)
                    print(store.themeList.count)
                    print(store.themeList)
                })
                //.environmentObject(store)
            }
            .listRowSpacing(10.0)
            .scrollContentBackground(.hidden)
            .navigationTitle("Choose Theme")
            .navigationBarItems(trailing: Button(action: {} , label: { NavigationLink(destination: AddThemeView(store: store)){Image(systemName: "plus").imageScale(.large).scrollContentBackground(.visible)}}))
            .sheet(item: $selectedTheme, content:  { theme in
                EditThemeView(store: store, theme: theme)
            })
        }
    }
    
    var vectorView: some View {
        VStack {
            Image("VectorThemeList3")
                .resizable()
                .scaledToFit()

            
            Spacer(minLength: 200)
            
            Image("VectorThemeList2")
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            Image("VectorThemeList1")
                .resizable()
                .scaledToFit()
            
       
        }
    }
}

struct EmojiThemeRow: View {
    let theme: Theme
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                    Text(theme.name)
                    .foregroundStyle(.white)
                    .font(.headline)
                    .padding()
                HStack(spacing: 70) {
                        Text("Emoji: \(theme.emojis.joined())").lineLimit(2)
                        .foregroundStyle(.white)
                    Text("\(Image(systemName: "rectangle.on.rectangle"))\(theme.numberOfCards)")
                        .foregroundStyle(.white)
                    }
                
            }
        }
    }
}

struct ThemeListView_Preview: PreviewProvider {
    static var previews: some View {
        ThemeListView()
    }
}
