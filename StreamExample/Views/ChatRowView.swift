import SwiftUI
import StreamChat

struct ChatRowView: View {
    let message: ChatMessage    // ChatMessage, FakeMessage
    
    var body: some View {
        HStack(alignment: .top) {
            HStack(alignment: .top) {
                if !message.isSentByCurrentUser {
                    UserView(message: message)
                }
                
                VStack(alignment: message.isSentByCurrentUser ? .trailing : .leading, spacing: 5) {
                    Text(message.text)
                        .padding(10)
                        .foregroundColor(message.isSentByCurrentUser ? .white : .primary)
                        .background(message.isSentByCurrentUser ? Color.green : Color.gray.opacity(0.5))
                        .clipShape(ChatBubble(corner: message.isSentByCurrentUser ? .topLeft : .topRight))
                    
                    Text(message.createdAt.longString())
                        .font(.caption)
                }
                
                if message.isSentByCurrentUser {
                    UserView(message: message)
                }
            }
            .frame(width: UIScreen.main.bounds.width - 65,
                   alignment: message.isSentByCurrentUser ? .trailing : .leading)
        }
        .frame(maxWidth: .infinity, alignment: message.isSentByCurrentUser ? .trailing : .leading)
    }
}

/*
struct ChatRowView_Previews: PreviewProvider {
    static var previews: some View {
        ChatRowView(message: FakeMessage.instance2)
    }
}
*/
