import SwiftUI
import StreamChat

class ViewModel: ObservableObject {
    @Published var channels: [ChatChannelController.ObservableObject] = []
    @Published var channelName = ""
    @Published var username = ""
    @Published var loading = false
    @Published var showAddChannelView = false
    @Published var searchText = ""
    @Published var newMessage = ""
    
    @Published var hasError = false
    @Published var errorMessage: String? = nil {
        didSet {
            hasError = errorMessage != nil
        }
    }
    
    var filterChannels: [ChatChannelController.ObservableObject] {
        if searchText.isEmpty {
            return channels
        }
        
        return channels.filter { $0.channel?.name?.localizedCaseInsensitiveContains(searchText) ?? false }
    }
    
    var sortedChannels: [ChatChannelController.ObservableObject] {
        return filterChannels.sorted {
            if let dt1 = $0.channel?.latestMessages.first?.createdAt {
                if let dt2 = $1.channel?.latestMessages.first?.createdAt {
                    return dt1 > dt2
                }
                
                return true
            }
            
            if let name1 = $0.channel?.name {
                if let name2 = $1.channel?.name {
                    return name1 < name2
                }
            }
            
            return true
        }
    }
    
    /*
     func sortChannels(){
         let result = streamData.channels.sorted { (ch1, ch2) -> Bool in
             if let date1 = ch1.channel?.latestMessages.first?.createdAt{
                 if let date2 = ch2.channel?.latestMessages.first?.createdAt{
                     return date1 > date2
                 } else{
                     return false
                 }
             } else{
                 return false
             }
         } 
         streamData.channels = result
     }
     */
    
    func login() {
        if username.isEmpty {
            errorMessage = "Please enter username."
            return
        }
        
        loading = true
        
        let config = ChatClientConfig(apiKeyString: Constants.APIKey)
        ChatClient.shared = ChatClient(config: config)
        
        let token: Token = .development(userId: username)
        ChatClient.shared.connectUser(userInfo: .init(id: username), token: token) { error in
            self.loading = false
            
            if let error = error {
                self.errorMessage = "Connection failed: \(error)"
                return
            }
            
            UserDefaults.standard.set(self.username, forKey: Constants.UserID)
        }
    }
    
    func signOut() {
        ChatClient.shared.connectionController().disconnect()
        UserDefaults.standard.set("", forKey: Constants.UserID)
    }
    
    func fetchAllChannels() {
        loading = true
        
        let controller = ChatClient.shared.channelListController(
            query: .init(
                filter: .equal(.type, to: .messaging)
            )
        )
        
        controller.synchronize { error in
            self.loading = false
            
            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }

            self.channels = controller.channels.map {
                ChatClient.shared.channelController(for: $0.cid).observableObject
            }
        }
    }

    func createChannel() {
        if channelName.isEmpty {
            errorMessage = "Please enter channel name."
            return
        }
        
        loading = true
        
        let newChannel = ChannelId(type: .messaging, id: UUID().uuidString)
        
        do {
            let controller = try ChatClient.shared.channelController(createChannelWithId: newChannel, name: channelName)
            
            controller.synchronize { error in
                self.loading = false
                
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                
                self.channelName = ""
                self.showAddChannelView = false
                self.fetchAllChannels()
            }
        }
        catch {
            errorMessage = error.localizedDescription
            loading = false
            return
        }
    }
    
    func deleteChannel(listener: ChatChannelController.ObservableObject) {
        loading = true
        
        listener.controller.deleteChannel { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }
            
            if let index = self.channels.firstIndex(where: { $0.channel?.cid == listener.channel?.cid }) {
                self.channels.remove(at: index)
            }
            
            self.loading = false
        }
    }
    
    func sendMessage(listener: ChatChannelController.ObservableObject) {
        
        listener.controller.createNewMessage(text: newMessage) { result in
            switch result {
            case .success(let messageId):
                print(messageId)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            self.newMessage = ""
        }
    }
}
