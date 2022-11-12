//
//  SignUpFirst.swift
//  LetsBusk
//
//  Created by Abdulaziz Albahar on 11/12/22.
//



import SwiftUI

struct SignUpFirst: View {
    @EnvironmentObject var userVM: UserViewModel
    
    @State var name = ""
    @State var email = ""
    @State var password = ""
    @State var firstRegPassed = false
    @State var errorOccurred = false
    
    var body: some View {
        VStack {
            Text("Sign-up").font(.system(size: 32, weight: .semibold, design: .rounded)).padding(.bottom, 0.75)
            
            Text("Create your account!").font(.system(size: 19, weight: .regular, design: .rounded)).foregroundColor(.secondary).padding(.bottom, 80)
            
            Group {
                Text("Full Name").font(.system(size: 18, weight: .semibold, design: .rounded)).frame( maxWidth: .infinity, alignment: .leading).padding(.leading, 32)
                
                TextField("John", text: $name).padding(.leading, 25).frame(width: 325, height: 50).background(Color("fieldOrange")).cornerRadius(20)
                
            }
            
            Group {
                
                Text("Email").font(.system(size: 18, weight: .semibold, design: .rounded)).frame( maxWidth: .infinity, alignment: .leading).padding(.leading, 32).padding(.top, 20)
                
                TextField("johnhenry@gmail.com", text: $email).padding(.leading, 25).frame(width: 325, height: 50).background(Color("fieldOrange")).cornerRadius(20)
            }
            
            Group {
                
                Text("Password").font(.system(size: 18, weight: .semibold, design: .rounded)).frame( maxWidth: .infinity, alignment: .leading).padding(.leading, 32).padding(.top, 20)
                
                SecureField("********", text: $password).padding(.leading, 25).frame(width: 325, height: 50).background(Color("fieldOrange")).cornerRadius(20)
            }
            
            Button(action: {
                userVM.signUp(name: name, email: email, password: password) { success in
                    withAnimation {
                        if success {
                            firstRegPassed = true
                        } else {
                            errorOccurred = true
                        }
                    }
                }
                
            }) {
                Text("Proceed").frame(minWidth: 345, minHeight: 60 ).background(.orange).cornerRadius(20).foregroundColor(.white).font(.system(size: 30, weight: .medium, design: .rounded))
            }.shadow(radius: 3).padding(.top, 150).navigationDestination(isPresented: $firstRegPassed, destination: {
                SignUpSecond().environmentObject(userVM)
            }).alert("Error!", isPresented: $errorOccurred) {
                Button("Ok.", role: .cancel, action: {
                    errorOccurred = false
                })
            }
        }
        
    }
}

struct SignUpFirst_Previews: PreviewProvider {
    static var previews: some View {
        SignUpFirst().environmentObject(UserViewModel())
    }
}