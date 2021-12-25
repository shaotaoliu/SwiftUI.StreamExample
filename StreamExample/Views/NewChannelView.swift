import SwiftUI

struct NewChannelView: View {
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create New Channel")
                .font(.title2)
                .fontWeight(.semibold)
            
            TextField("Enter Channel Name", text: $vm.channelName)
                .font(.title3)
                .textFieldStyle(MyTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            Button("Create") {
                vm.createChannel()
            }
            .font(.title3)
            .disabled(vm.channelName.isEmpty)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 30)
        .background(
            Color.primary.opacity(0.2)
                .ignoresSafeArea()
                .onTapGesture {
                    vm.channelName = ""
                    vm.showAddChannelView = false
                }
        )
    }
}

struct NewChannelView_Previews: PreviewProvider {
    static var previews: some View {
        NewChannelView()
            .environmentObject(ViewModel())
    }
}
