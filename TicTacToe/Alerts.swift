import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}


struct AlertContent {
    static let humanWin = AlertItem(title: Text("You Win!"), message: Text("You won computer"), buttonTitle: Text("Play Again"))
    static let computerWin = AlertItem(title: Text("You Lost"), message: Text("You should do better"), buttonTitle: Text("Rematch"))
    static let draw = AlertItem(title: Text("Draw"), message: Text("You should do better"), buttonTitle: Text("Try Again"))
}
