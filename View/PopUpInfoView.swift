import SwiftUI


struct PopUpInfoView: View {
    var body: some View {
        ZStack {
            Color(red: 233.0/255, green: 233.0/255, blue: 233.0/255)
                .ignoresSafeArea()
            vectorView
            VStack {
                Spacer()
                Text("Welcome to MindCraft Duo")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                
                ScrollView {
                    VStack(spacing: 15) {
                        Text("A captivating duo of classic games to challenge your mind!")
                            .font(.headline)
                            .multilineTextAlignment(.center)
                        
                        Text("Memorise Cards")
                            .font(.headline)
                             Text("Put your cognitive skills to the test in this addictive memory game! Your mission is to uncover pairs of matching cards from a deck scattered face-down. Sharpen your focus, trust your memory, and embark on the exciting challenge of Memorise Cards!")
                            .font(.callout)
                            .multilineTextAlignment(.center)
                        
                        Text("TicTacToe").font(.headline) 
                             Text("The classic game of strategy and wits! Compete against friends or challenge the computer in this timeless battle of Xs and Os.  Are you ready to master the grid and become the ultimate TicTacToe champion?")
                            .font(.callout)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                }
            }
            .padding()
        }
        
    }
    var vectorView: some View {
        VStack{
            Image("Vector 2")
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            Image("Vector 3")
                .resizable()
                .scaledToFit()
                .clipped()
        }
    }
}


struct PopUpInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpInfoView()
    }
}
