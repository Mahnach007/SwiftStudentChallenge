

import SwiftUI

struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    
    var body: some View {
        ZStack {
            Image("Ellipse")
                .resizable()
                .scaledToFit()
                .padding(5)
            Text(card.content)
                    .font(.system(size: 130))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
                    .padding()
        }
        .cardify(isFaceUp: card.isFacedUp)
        .opacity(card.isFacedUp || !card.isMatched ? 1 : 0 )
    }
}

struct CardView_Previews: PreviewProvider {
    
    typealias Card = MemoryGame<String>.Card
    
    static var previews: some View {
        CardView(Card(content: "de"))
            .foregroundColor(.green)
            .padding()
    }
}
