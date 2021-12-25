import SwiftUI
import StreamChat

struct ChannelRowView: View {
    @ObservedObject var listener: ChatChannelController.ObservableObject
    
    var body: some View {
        HStack(spacing: 15) {
            Circle()
                .fill(.blue)
                .frame(width: 50, height: 50)
                .overlay(
                    Text(getNameInitial())
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                )
            
            VStack(alignment: .leading, spacing: 8) {
                Text(listener.channel?.name ?? "")
                    .font(.system(size: 22))
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                HStack {
                    Text(getLastMessage())
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .lineLimit(1)
                    
                    Spacer(minLength: 10)
                    
                    Text(getLastTime())
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                }
            }
        }
    }
    
    func getNameInitial() -> String {
        if let name = listener.channel?.name, !name.isEmpty {
            return String(name.first!)
        }
        
        return ""
    }
    
    func getLastMessage() -> String {
        guard let lastMessage = listener.channel?.latestMessages.first else {
            return ""
        }

        guard let title = lastMessage.isSentByCurrentUser ? "Me" : "\(lastMessage.author.id)" else {
            return ""
        }

        return "\(title): \(lastMessage.text)"
    }
    
    func getLastTime() -> String {
        guard let lastMessage = listener.channel?.latestMessages.first else {
            return ""
        }

        return lastMessage.createdAt.toString()
    }
}

/*
struct ChannelRowView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelRowView(channel: FakeChannel())
    }
}

struct FakeChannel {
    let cid = "12345"
    let name: String? = "Example"
}
*/
