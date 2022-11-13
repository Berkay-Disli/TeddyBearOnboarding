//
//  Onboarding.swift
//  RiveComponents
//
//  Created by Berkay Disli on 13.11.2022.
//

import SwiftUI
import RiveRuntime

struct Onboarding: View {
    var loginCharacter = RiveViewModel(fileName: "loginCharacter", stateMachineName: "Login Machine")
    var loadingView = RiveViewModel(fileName: "loading", artboardName: "New Artboard")
    @State private var username = ""
    @State private var password = ""
    @State private var signInSuccessful: Bool?
    @State private var isLoading = false
    @FocusState private var focusedField: Field?
    
    enum Field: Hashable {
            case usernameField
            case passwordField
        }
    
    var body: some View {
        ZStack {
            Color("bg").ignoresSafeArea()
                .onTapGesture {
                    focusedField = .none
                }
            VStack(spacing: 0) {
                loginCharacter.view()
                    .frame(height: 325)
                    .padding(.top, -60)
                    .onTapGesture {
                        focusedField = .none
                    }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(.white)
                        .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 5)
                        .onTapGesture {
                            focusedField = .none
                        }
                    
                    VStack(spacing: 0) {
                        Text("TEDDY BEAR")
                            .foregroundColor(Color("fg"))
                            .font(.system(size: 40))
                            .fontWeight(.medium)
                            .tracking(10)
                            .padding(.top)
                            .offset(x: 5)
                            .onTapGesture {
                                focusedField = .none
                            }
                        
                        VStack {
                            HStack {
                                Image(systemName: "person")
                                    .foregroundColor(.gray)
                                TextField("username", text: $username)
                                    .focused($focusedField, equals: .usernameField)
                                    .autocorrectionDisabled()
                                    .textInputAutocapitalization(.never)
                                    .onChange(of: focusedField) { newValue in
                                        if focusedField == .usernameField {
                                            loginCharacter
                                                .setInput("isChecking", value: true)
                                        } else {
                                            loginCharacter
                                                .setInput("isChecking", value: false)
                                        }
                                    }
                                    .onChange(of: username.count) { newValue in
                                        loginCharacter
                                            .setInput("numLook", value: Float(newValue))
                                    }
                            }
                            .padding()
                            .background(.gray.opacity(0.1))
                            .cornerRadius(5)
                            
                            HStack {
                                Image(systemName: "lock")
                                    .foregroundColor(.gray)
                                SecureField("password", text: $password)
                                    .focused($focusedField, equals: .passwordField)
                                    .onChange(of: focusedField) { newValue in
                                        if focusedField == .passwordField {
                                            loginCharacter
                                                .setInput("isHandsUp", value: true)
                                        } else {
                                            loginCharacter
                                                .setInput("isHandsUp", value: false)
                                        }
                                    }
                            }
                            .padding()
                            .background(.gray.opacity(0.1))
                            .cornerRadius(5)
                            
                            Button {
                                if !username.isEmpty && !password.isEmpty {
                                    focusedField = .none
                                    isLoading = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
                                        isLoading = false
                                        if username == "iosdev22" && password == "seda22" {
                                            signInSuccessful = true
                                            loginCharacter
                                                .triggerInput("trigSuccess")
                                        } else {
                                            signInSuccessful = false
                                            loginCharacter
                                                .triggerInput("trigFail")
                                        }
                                    }
                                }
                                    
                                
                            } label: {
                                Text("Sign In")
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical)
                                    .background(.black.opacity(0.75))
                                    .cornerRadius(5)
                            }
                        }
                        .padding(.top)

                        
                        Spacer()
                    }
                    .padding(.horizontal)
                        
                }
                .frame(height: 300)
                .padding(.horizontal)
                    
                Spacer()
                
                Text("Already have an account? **Sign In**")
                    .font(.system(size: 15))
                    .foregroundColor(Color("fg"))
            }
            
            if isLoading {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
                    .frame(width: 240, height: 240)
                    .overlay {
                        loadingView.view()
                            .frame(width: 200, height: 200)
                            .onAppear {
                                loadingView.play()
                            }
                            .onDisappear {
                                loadingView.stop()
                            }
                    }
                    .transition(AnyTransition.opacity.animation(.easeInOut))
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}