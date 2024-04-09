

import SwiftUI

struct FlyingNumber: View {
    @State private var offset: CGFloat = 0
    
    let number: Int
    
    
    var body: some View {
        if number != 0 {
            Text(number, format: .number.sign(strategy: .always()))
                .font(.largeTitle)
                .foregroundColor( number < 0 ? .red : .green)
                .offset(x: 0, y: offset)
                .opacity(offset != 0 ? 0 : 1)
                .onAppear {
                    withAnimation(.easeIn(duration: 1)) {
                        offset = number < 0 ? 100 : -100
                    }
                }
                .onDisappear {
                    offset = 0
                }
        }
    }
}

struct FlyingNumber_Previews: PreviewProvider {
    static var previews: some View {
        FlyingNumber(number: 5)
    }
}
