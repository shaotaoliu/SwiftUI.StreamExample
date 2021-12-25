import SwiftUI
import StreamChat

struct ChatView: View {
    @EnvironmentObject var vm: ViewModel
    @ObservedObject var listener: ChatChannelController.ObservableObject
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 20) {
                        ForEach(listener.messages.reversed(), id: \.id) { message in
                            ChatRowView(message: message)
                        }
                    }
                    .id("bottomId")
                }
                .onChange(of: listener.messages, perform: { _ in
                    withAnimation {
                        proxy.scrollTo("bottomId", anchor: .bottom)
                    }
                })
                .onAppear(perform: {
                    withAnimation {
                        proxy.scrollTo("bottomId", anchor: .bottom)
                    }
                })
            }
            .padding(.bottom, 10)
            
            HStack {
                TextField("Message", text: $vm.newMessage)
                    .textFieldStyle(MyTextFieldStyle())
                    .onSubmit {
                        if !vm.newMessage.isEmpty {
                            vm.sendMessage(listener: listener)
                        }
                    }
                
                Button(action: {
                    vm.sendMessage(listener: listener)
                }, label: {
                    Image(systemName: "paperplane.fill")
                        .padding(10)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(Circle())
                })
                    .disabled(vm.newMessage.isEmpty)
                    .opacity(vm.newMessage.isEmpty ? 0.5 : 1)
            }
        }
        .padding()
        .navigationTitle(listener.channel?.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

/*
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
*/
