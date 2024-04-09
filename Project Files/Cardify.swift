import SwiftUI

struct Cardify: ViewModifier, Animatable {

    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var rotation: Double
    var animatableData: Double {
        get { return rotation}
        set { rotation = newValue }
    }

    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base.strokeBorder(lineWidth: Constants.lineWidth)
                .background(base.fill(Constants.mainColor))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            base.fill(Constants.mainColor)
                .overlay(content: { 
                        Image("backCardView")
                            .resizable()
                            .scaledToFit()
                            .padding(7)
                })
                .opacity(isFaceUp ? 0 : 1)
        }.rotation3DEffect(.degrees(rotation), axis:(0,1,0))
        
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 0
        static let mainColor = LinearGradient(gradient: Gradient(colors: [Color(red: 83.0/255, green: 86.0/255, blue: 91.0/255), Color(red: 38.0/255, green: 45.0/255, blue: 61.0/255)]), startPoint: .top, endPoint: .bottom)
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
