import SwiftUI

struct TictactoeView: View {
    
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        ZStack {
            ThemeListView().vectorView
            LazyVGrid(columns: viewModel.columns) {
                ForEach(0..<9) { i in
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(viewModel.mainColor)
                            .frame(width: 100, height: 100)

                        
                        Image(systemName: viewModel.moves[i]?.indicator ?? "")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(viewModel.gradientColor)
                        
                    }
                    .onTapGesture {
                        viewModel.playerMove(for: i)
                    }
                    
                }
                .navigationTitle("TicTacToe")
                
            }
            .navigationBarItems(trailing: 
                                    Button(action: { viewModel.resetGame() },
                                           label: { Image(systemName: "arrow.clockwise").imageScale(.large) }))
        }
        .padding(5)
        .disabled(viewModel.isGameboardDisabled)
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: .default(alertItem.buttonTitle, action: {viewModel.resetGame()} ))
        })
        .background(Color(red: 233.0/255, green: 233.0/255, blue: 233.0/255).ignoresSafeArea())
    }
}

enum Player {
    case human, computer
}

struct Move {
 let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}

struct TictactoeView_Preview: PreviewProvider {
    static var previews: some View {
        TictactoeView()
    }
}
