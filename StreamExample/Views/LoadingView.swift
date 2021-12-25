import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.primary
                .opacity(0.2)
                .ignoresSafeArea()
            
            ProgressView()
                .frame(width: 50, height: 50)
                .background(Color.white)
                .cornerRadius(6)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
