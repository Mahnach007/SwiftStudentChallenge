

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    @State private var isAlertShown: Bool = false
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 2/3


    var body: some View {
            ZStack {
                Color(red: 233.0/255, green: 233.0/255, blue: 233.0/255).ignoresSafeArea()
                vectorView
                VStack{
                    cards
                    HStack {
                        Text("Score: \(viewModel.score)")
                            .animation(nil)
                            .font(.title)
                            .bold()
                        Spacer()
                        deck
                        Spacer()
                        VStack{
                            Button(action: {
                                withAnimation {
                                    viewModel.shuffle()
                                }
                            }) {
                                Text("Shuffle")
                                    .foregroundColor(Color.white)
                                    .font(.headline)
                                    .padding()
                                    .frame(width: 90, height: 45)
                                    .background(
                                        AngularGradient(colors: [.orange, .pink, .blue, .green], center: .center))
                                    .cornerRadius(7.0)
                                
                            }
                            
                        }
                        
                    }
                }
                .padding()
                .navigationBarItems(trailing: 
                                        Button(action: { viewModel.restart() },
                                               label: { Image(systemName: "arrow.clockwise").imageScale(.large) }))
                        .alert("Game Over", isPresented: $isAlertShown) {
                            Button{
                                viewModel.restart()
                            }label: {
                                Text("Restart game")
                            }
                        }message: { 
                            Text("You finished the game \n with score of \(viewModel.score)")
                        }
            }.onDisappear {
                viewModel.restart()
            }
    }
    
    private var cards: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: aspectRatio) { card in
            if isDealt(card) {
                return AnyView(
                    CardView(card)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .transition(.asymmetric(insertion: .identity, removal: .identity))
                        .padding(3)
                        .overlay(FlyingNumber(number: ScoreChange(cusedBy: card)))
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.7)){
                                DispatchQueue.main.async {
                                    let isAllCardMatched = viewModel.isAllCardMatched()
                                    if isAllCardMatched {
                                        isAlertShown = true
                                    }
                                }
                    
                                let scoreBeforeChoosing = viewModel.score
                                viewModel.choose(card)
                                let scoreChange = viewModel.score - scoreBeforeChoosing
                                lastScoreChange = (scoreChange, card.id)
                            }
                            if !card.isFacedUp {
                                SoundManager.instance.playEffect(of: .cardFlip)
                            }
                        }
                )
                
            } else {
                return AnyView(EmptyView())
            }
        }
    }
    var vectorView: some View {
        VStack{
            
            Image("VectorCards3")
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            Image("VectorCards2")
                .resizable()
                .scaledToFit()

            
            Spacer()
            
            Image("VectorCards1")
                .resizable()
                .scaledToFit()

        }
    }
    
    @State private var lastScoreChange = (0, causedByCardID: "")
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        viewModel.cards.filter{ !isDealt($0) }
    }
    
    @Namespace private var dealingNamespace
    
    private var deck: some View {
        ZStack {
            ForEach(undealtCards) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                }
        }
        .frame(width: 50, height: 50 / aspectRatio)
        .onTapGesture {
            var delay: TimeInterval = 0
            for card in viewModel.cards {
                
                withAnimation(.easeInOut(duration: 1).delay(delay)) {
                    _ = dealt.insert(card.id)
                }
                delay += 0.15
            }
            
        }
    }
    
    private func ScoreChange(cusedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
}
    
    struct EmojiMemoryGameView_Previews: PreviewProvider {
        static var previews: some View {
            EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: Theme(name: "dcd", emojis: ["😃", "😁", "🥸", "🤬", "🥵", "🥶", "🇪🇸", "💘"], numberOfCards: 6)))
            
        }
        
    }


