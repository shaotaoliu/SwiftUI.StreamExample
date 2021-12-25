import SwiftUI

struct LoginView: View {
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter username", text: $vm.username)
                .font(.title2)
                .textFieldStyle(MyTextFieldStyle())
                .autocapitalization(.none)
            
            Button(action: {
                vm.login()
            }, label: {
                Text("Login")
                    .font(.title2)
            })
                .disabled(vm.username.isEmpty)
                .alert("Error", isPresented: $vm.hasError, presenting: vm.errorMessage, actions: { message in
                    
                }, message: { message in
                    Text(message)
                })
            
            Spacer()
        }
        .padding()
        .padding(.top, 10)
        .navigationTitle("Login")
    }
}

struct MyTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .background(Color.white)
            .cornerRadius(5)
            .shadow(color: Color.primary.opacity(0.1), radius: 5)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(ViewModel())
    }
}
