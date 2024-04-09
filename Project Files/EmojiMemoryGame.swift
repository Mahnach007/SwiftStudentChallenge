
import SwiftUI


class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    @Published private var model: MemoryGame<String>
    

    
    init(theme: Theme) {
        self.model = EmojiMemoryGame.createMemoryGame(theme: theme)
        model.shuffle()
    }
    
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        return MemoryGame(theme: theme) { pairIndex in
            if theme.emojis.indices.contains(pairIndex) {
                return theme.emojis[pairIndex]
            } else {
                return "Add more emojis"
            }
        }
    }
    
    func isAllCardMatched() -> Bool {
        let matchedCount = cards.filter { $0.isMatched }.count
        return matchedCount == cards.count
    }
    
    var isShown: Bool {
        
        model.isShown
    }
    var cards: Array<Card> {
        return model.cards
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    
//    func changeTheme(_ newTheme: Theme) -> MemoryGame<String> {
//        model = EmojiMemoryGame.createMemoryGame(theme: newTheme)
//        return model
//    }
    
    func restart() {
        model.restart()
    }
    
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
