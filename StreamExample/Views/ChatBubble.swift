import SwiftUI

struct ChatBubbleView: View {
    var body: some View {
        VStack(spacing: 50) {
            ChatBubble(corner: .topLeft)
                .fill(.blue)
                .frame(width: 200, height: 100)
            
            ChatBubble(corner: .topRight)
                .fill(.blue)
                .frame(width: 200, height: 100)
        }
    }
}

struct ChatBubble: Shape {
    var corner: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let corners: UIRectCorner = [corner, .bottomLeft, .bottomRight]
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: 10, height: 10))
        
        return Path(path.cgPath)
    }
}

struct ChatBubble_Previews: PreviewProvider {
    static var previews: some View {
        ChatBubbleView()
    }
}
