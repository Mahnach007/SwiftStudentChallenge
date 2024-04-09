import SwiftUI

class GameViewModel: ObservableObject {
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    let mainColor = LinearGradient(gradient: Gradient(colors: [Color(red: 83.0/255, green: 86.0/255, blue: 91.0/255), Color(red: 38.0/255, green: 45.0/255, blue: 61.0/255)]), startPoint: .top, endPoint: .bottom)
    let gradientColor = AngularGradient(colors: [.orange, .pink, .blue, .green], center: .center)
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isGameboardDisabled = false
    @Published var alertItem: AlertItem?
    
    func playerMove(for position: Int) {
        if isSquareFill(in: moves, index: position) { return }
        moves[position] = Move(player: .human , boardIndex: position)
        
        
        if checkWinCondition(for: .human, in: moves) {
            alertItem = AlertContent.humanWin
            return
        }
        
        if checkForDraw(in: moves) {
            alertItem = AlertContent.draw
            return
        }
        
        isGameboardDisabled = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            let computerPosition = assignComputerMovePosition(in: moves)
            moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
            isGameboardDisabled = false
            
            if checkWinCondition(for: .computer, in: moves) {
                alertItem = AlertContent.computerWin
                return
            }
            
            if checkForDraw(in: moves) {
                alertItem = AlertContent.draw
                return
            }
        }
    }
    
    func isSquareFill(in moves: [Move?], index: Int) -> Bool {
        return moves.contains(where: {$0?.boardIndex == index })
    }
    
    func assignComputerMovePosition(in moves: [Move?]) -> Int {
        
        let winPaterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        let computerMoves = moves.compactMap{$0}.filter{$0.player == .computer}
        let computerPositions = Set(computerMoves.map{ $0.boardIndex })
        
        for pattern in winPaterns {
            let winPositions = pattern.subtracting(computerPositions)
            
            if winPositions.count == 1 {
                let isAvaiable = !isSquareFill(in: moves, index: winPositions.first!)
                if isAvaiable { return winPositions.first!}
            }
        }
        
        
     
        
        let humanMoves = moves.compactMap{$0}.filter{$0.player == .human}
        let humanPositions = Set(humanMoves.map{ $0.boardIndex })
        
        for pattern in winPaterns {
            let winPositions = pattern.subtracting(humanPositions)
            
            if winPositions.count == 1 {
                let isAvaiable = !isSquareFill(in: moves, index: winPositions.first!)
                if isAvaiable { return winPositions.first!}
            }
        }
        
        var movePosition = Int.random(in: 0..<9)
        
        while isSquareFill(in: moves, index: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        let playerMoves = moves.compactMap{$0}.filter{$0.player == player}
        let playerPositions = Set(playerMoves.map{ $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) {
            return true
        }
        
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap{$0}.count == 9
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
    }
}
