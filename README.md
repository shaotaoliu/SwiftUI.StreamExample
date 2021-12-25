# SwiftUI.StreamExample

To use stream, you need to add package: https://github.com/GetStream/stream-chat-swift.git

The following shows how to connect a user (login):

```Swift
let config = ChatClientConfig(apiKeyString: "<Your API Key>")
ChatClient.shared = ChatClient(config: config)
let token: Token = .development(userId: "<Your User ID>")

ChatClient.shared.connectUser(userInfo: .init(id: "<Your User ID>"), token: token) { error in 
    if let error = error { 
        print("Connection failed with: \(error)")
        return
    }
}
```

![image](https://user-images.githubusercontent.com/15805568/147377108-5b931b85-d017-464c-bad8-d1e27fded47a.png)

The following creates a guest user:

```Swift
ChatClient.shared.connectGuestUser(userInfo: .init(id: "<Your User ID>")) { error in 
    if let error = error { 
        print("Connection failed with: \(error)")
        return
    }
}
```

The following creates an anonymous user:

```Swift
ChatClient.shared.connectAnonymousUser() { error in
    if let error = error { 
        print("Connection failed with: \(error)")
        return
    }
}
```

The following shows the channels screen. The channels are sorted by the sent time of the last messages.

![image](https://user-images.githubusercontent.com/15805568/147377889-af9bd6f7-7534-4e49-b523-3a70616e6407.png)

You can add new channels.

![image](https://user-images.githubusercontent.com/15805568/147377907-d1b7605b-87e0-4297-95af-8a52c308e3a1.png)

The following shows the messages sent in a channel.

![image](https://user-images.githubusercontent.com/15805568/147377922-7ac07337-0d01-4da1-88fd-7b4df9ab70a2.png)

Create Stream App: https://dashboard.getstream.io/dashboard/v2/organization/1101522

Stream Documents: https://getstream.io/chat/docs/ios-swift/?language=swift
