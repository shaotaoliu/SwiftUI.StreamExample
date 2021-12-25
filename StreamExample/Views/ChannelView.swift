import SwiftUI

struct ChannelView: View {
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        List {
            ForEach(vm.sortedChannels, id: \.channel) { listener in
                ZStack {
                    ChannelRowView(listener: listener)
                        .padding(.vertical, 7)
                    
                    NavigationLink(destination: ChatView(listener: listener), label: {
                        EmptyView()
                    })
                        .opacity(0)
                }
            }
            .onDelete { indexSet in
                for index in indexSet {
                    vm.deleteChannel(listener: vm.sortedChannels[index])
                }
            }
        }
        .searchable(text: $vm.searchText)
        .listStyle(.plain)
        .navigationTitle("Channels")
        .padding(.top, 5)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button("Create") {
                    withAnimation {
                        vm.showAddChannelView = true
                    }
                }
            })
        })
        .onAppear() {
            vm.fetchAllChannels()
        }
    }
}

struct ChannelView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelView()
            .environmentObject(ViewModel())
    }
}
