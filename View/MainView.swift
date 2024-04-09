

import SwiftUI

struct MainView: View {
    
    @State var isInfoViewOn = false
    @State var isSettingViewOn = false
    let iconSize: CGFloat = 35
    let sound = SoundManager.instance
    
    var body: some View {
        NavigationView {
            ZStack{
                Color(red: 233.0/255, green: 233.0/255, blue: 233.0/255)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    toolBarView
                    vectorView
                }
                mainView
            }
        }
    }
    
    var toolBarView: some View {
        HStack {
            Image(systemName: "info.circle")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: iconSize, maxHeight: iconSize)
                .onTapGesture{
                    isInfoViewOn.toggle()
                    sound.playEffect(of: .buttonClick)
                }
                .popover(isPresented: $isInfoViewOn){
                    PopUpInfoView()
                }
            Spacer()
            
            Image(systemName: "gear")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: iconSize, maxHeight: iconSize)
                .onTapGesture{
                    isSettingViewOn.toggle()
                    sound.playEffect(of: .buttonClick)
                }
                .popover(isPresented: $isSettingViewOn){
                    PopUpSettingView()
                }
            
        }.padding()
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
            
            Spacer()
            
            Image("Vector 1")
                .resizable()
                .scaledToFit()
                .clipped()

        }
}
    
    var mainView: some View{ 
        
        VStack {
            ZStack(alignment: .bottom) {
                Image("Card deck")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 550, maxHeight: 400)
                Image("MainTitle")
                    .resizable()
                    .scaledToFit()
            }

            
            VStack {

                NavigationLink(destination: ThemeListView()) {
                    Text("Cardmorize")
                        .foregroundStyle(.white)
                        .bold()
                        .font(.title)
                        .frame(width: 177, height: 50)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(red: 83.0/255, green: 86.0/255, blue: 91.0/255), Color(red: 38.0/255, green: 45.0/255, blue: 61.0/255)]), startPoint: .top, endPoint: .bottom))
                        .border(AngularGradient(colors: [.orange, .pink, .blue, .green], center: .center), width: 3)
                        .cornerRadius(7.0)
                        .shadow(radius: 7, x: 10)
                        .scaleEffect(1.0, anchor: .center)
                }.simultaneousGesture(TapGesture().onEnded{
                    sound.playEffect(of: .buttonClick)
                })
                NavigationLink(destination: TictactoeView()) {
                    Text("TicTacToe")
                        .foregroundStyle(.white)
                        .bold()
                        .font(.title)
                        .frame(width: 177, height: 50)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(red: 83.0/255, green: 86.0/255, blue: 91.0/255), Color(red: 38.0/255, green: 45.0/255, blue: 61.0/255)]), startPoint: .top, endPoint: .bottom))
                        .border(AngularGradient(colors: [.orange, .pink, .blue, .green], center: .center), width: 3)
                        .cornerRadius(7.0)
                        .shadow(radius: 7, x: 10)
                        .scaleEffect(1.0, anchor: .center)
                    
                }.simultaneousGesture(TapGesture().onEnded{
                    sound.playEffect(of: .buttonClick)
                })
                
            }
        }

        .padding()
    }
}



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
