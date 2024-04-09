import SwiftUI

struct Theme: Identifiable, Hashable, Encodable, Decodable {

    var id = UUID()
    var name: String
    var emojis: [String]
    var numberOfCards: Int
    
    init(name: String, emojis: [String], numberOfCards: Int) {
        self.name = name
        self.emojis = emojis
        self.numberOfCards  = numberOfCards
    }
    
}

class ThemeStore: ObservableObject {
    
    static var themes: [Theme] = [
        Theme(name: "Cars", emojis: [ "🚗","🚕","🚙","🚌","🚎","🚐","🚒","🚑","🚓","🏎️","🛻","🚚","🚛","🚜"], numberOfCards: 10),
        Theme(name: "Food", emojis: ["🍏","🍎","🍐","🍊","🍋","🫐","🍓","🍇","🍉","🍌","🍈","🍒","🍑","🥭","🍍"], numberOfCards: 8),
        Theme(name: "Face", emojis: ["😀","😃","😅","🥹","☺️","😊","🙂","😎","🥸","🥳","🤩","🤬","🤯","😠","🥵"], numberOfCards: 6)
    ]
    
    @Published var themeList: [Theme] {
            didSet {
                saveThemesToUserDefaults()
            }
        }
    
    init() {
            self.themeList = ThemeStore.loadThemesFromUserDefaults()
        }
    
    func addTheme(theme: Theme) {
        themeList.append(theme)
    }
    
    
    static func getThemes() -> [Theme] {
        return themes
    }
    
    private func saveThemesToUserDefaults() {
           let encoder = JSONEncoder()
           if let encoded = try? encoder.encode(themeList) {
               UserDefaults.standard.set(encoded, forKey: "themeList")
           }
       }
       
       private static func loadThemesFromUserDefaults() -> [Theme] {
           if let themeData = UserDefaults.standard.data(forKey: "themeList") {
               let decoder = JSONDecoder()
               if let decodedThemes = try? decoder.decode([Theme].self, from: themeData) {
                   return decodedThemes
               }
           }
           return themes // If there's no saved data, return default themes
       }
    
}

