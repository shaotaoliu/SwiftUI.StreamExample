import SwiftUI
import StreamChat

@main
struct StreamExampleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ViewModel())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    @AppStorage(Constants.UserID) var currentUserId: String = ""
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let config = ChatClientConfig(apiKeyString: Constants.APIKey)
        ChatClient.shared = ChatClient(config: config)
        
        if !currentUserId.isEmpty {
            let token: Token = .development(userId: currentUserId)

            ChatClient.shared.connectUser(userInfo: .init(id: currentUserId), token: token) { error in
                if let error = error {
                    print("Connection failed: \(error)")
                }
            }
        }
        
        return true
    }
}

extension ChatClient {
    static var shared: ChatClient!
}
