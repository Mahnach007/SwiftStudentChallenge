import SwiftUI

struct PopUpSettingView: View {
    @AppStorage("isMusicOn") private var isMusicOn = false
    @AppStorage("isEffectsOn") private var isEffectsOn = false
    
    var body: some View {
        ZStack {
            
            Color(red: 233.0/255, green: 233.0/255, blue: 233.0/255)
                .ignoresSafeArea()
            PopUpInfoView().vectorView
            VStack(spacing: 20) {
                Text("Settings")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 10) {

                        
                    Toggle("Music", isOn: $isMusicOn)
                        .onChange(of: isMusicOn) {
                            updateMusicState()
                        }
                        .foregroundStyle(.white)
                    Toggle("Sound Effects", isOn: $isEffectsOn)
                        .onChange(of: isEffectsOn) {
                            updateEffectState()
                        }.foregroundStyle(.white)
                }
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [Color(red: 83.0/255, green: 86.0/255, blue: 91.0/255), Color(red: 38.0/255, green: 45.0/255, blue: 61.0/255)]), startPoint: .top, endPoint: .bottom))
                .cornerRadius(10)
                .shadow(radius: 5)
                
                Spacer()
            }
            .padding()
        }
    }
    
    private func updateMusicState() {
        if isMusicOn {
            SoundManager.instance.playMusic()
        } else {
            SoundManager.instance.stopMusic()
        }
    }
    private func updateEffectState() {
        if isEffectsOn {
            SoundManager.playEffect = isEffectsOn
        } else {
            SoundManager.playEffect = isEffectsOn
        }
    }
}

struct PopUpSettingView_Preview: PreviewProvider {
    static var previews: some View {
        PopUpSettingView()
    }
}
