
import Foundation
import SwiftUI


struct MemoryGame<CardContent> where CardContent: Equatable {
    
    var isShown: Bool = false 

    private(set) var cards: [Card] // Allowed only to see what we                                     have,not set value
    private(set) var score: Int = 0
    
    
    var indexOfTheOneAndOnlyFacedUpCard: Int? {
        get {
            return cards.indices.filter{ index in cards[index].isFacedUp }.only
        }
        
        set {
            cards.indices.forEach { cards[$0].isFacedUp = (newValue == $0)
            }
        }
    }
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFacedUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFacedUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    } else {
                        if cards[chosenIndex].hasBeenSeen {
                            score -= 1
                        }
                        if cards[potentialMatchIndex].hasBeenSeen {
                            score -= 1
                        }
                    }
                    
                } else {
                    
                    indexOfTheOneAndOnlyFacedUpCard = chosenIndex
                }
                
                cards[chosenIndex].isFacedUp = true
            }
                
        }
        isShown = cards.filter{!$0.isMatched}.count == 0
    }
    
    private func index(of card: Card) -> Int? {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    }
    
    init(theme: Theme, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<max(2, theme.numberOfCards) {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    mutating func restart() {
        for index in cards.indices {
            if cards[index].isMatched || cards[index].isFacedUp {
                    cards[index].hasBeenSeen = false
                    cards[index].isMatched = false
                    cards[index].isFacedUp = false
                    score = 0
                
            }
        }
        shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        
        
        var isFacedUp: Bool = false {
            didSet {
                if oldValue && !isFacedUp {
                    hasBeenSeen = true
                }
            }
        }
        var hasBeenSeen: Bool = false
        var isMatched: Bool = false
        let content: CardContent
        
        var id: String = UUID().uuidString
        var debugDescription: String {
            "\(id): content \(content) \(isFacedUp ? "up" : "down") \(isMatched ? "matched" : "different")"
        }
    }
}

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
