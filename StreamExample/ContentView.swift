import SwiftUI

struct ContentView: View {
    @AppStorage(Constants.UserID) var currentUserId: String = ""
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if currentUserId.isEmpty {
                    LoginView()
                }
                else {
                    ChannelView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if !currentUserId.isEmpty {
                        Button("Sign Out") {
                            vm.signOut()
                        }
                    }
                }
            }
        }
        .overlay(
            ZStack {
                if vm.loading {
                    LoadingView()
                }
                
                if vm.showAddChannelView {
                    NewChannelView()
                }
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
