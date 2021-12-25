import SwiftUI
import StreamChat

struct UserView: View {
    let message: ChatMessage        // ChatMessage, FakeMessage
    
    var body: some View {
        Circle()
            .fill(message.isSentByCurrentUser ? Color.green : Color.gray.opacity(0.5))
            .frame(width: 40, height: 40)
            .overlay(
                Text("\(String(message.author.id.first!))")
                    .fontWeight(.semibold)
                    .foregroundColor(message.isSentByCurrentUser ? .white : .primary)
            )
            .contextMenu(menuItems: {
                Text("\(message.author.id)")
                
                Text("Status: \(message.author.isOnline ? "online" : "offline")")
            })
    }
}

/*
struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(message: FakeMessage.instance1)
    }
}
*/

struct FakeMessage {
    var isSentByCurrentUser: Bool = false
    var author: MessageAuthor
    var text = "How are you. It's nice to see you again. We have not seen each other for a long time"
    var createdAt = Date()
    
    init(isSentByCurrentUser: Bool, authorId: String, online: Bool) {
        self.isSentByCurrentUser = isSentByCurrentUser
        self.author = MessageAuthor(id: authorId, isOnline: online)
    }
    
    static var instance1: FakeMessage {
        return FakeMessage(isSentByCurrentUser: true, authorId: "Hello", online: true)
    }
    
    static var instance2: FakeMessage {
        return FakeMessage(isSentByCurrentUser: false, authorId: "Hello", online: false)
    }
}

struct MessageAuthor {
    var id: String
    var isOnline: Bool
}
