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
    @State private var showOnboarding = true
    
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
            if showOnboarding {
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
                                .fontWeight(signInSuccessful ?? false ? .bold:.medium)
                                .contentTransition(.interpolate)
                                .scaleEffect(signInSuccessful ?? false ? 1.12:1)
                                .animation(.easeInOut, value: signInSuccessful)
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
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                                    withAnimation(.easeInOut) {
                                                        self.showOnboarding = false
                                                    }
                                                }
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
                    
                    if signInSuccessful != true {
                        Text("Already have an account? **Sign In**")
                            .font(.system(size: 15))
                            .foregroundColor(Color("fg"))
                            .transition(.opacity.animation(.easeInOut))
                    }
                }
                .transition(AnyTransition.move(edge: .top).animation(.easeInOut))
                .zIndex(1)
            } else {
                VStack {
                    HStack {
                        Image(systemName: "line.3.horizontal")
                        Spacer()
                        Image(systemName: "magnifyingglass")
                    }
                    .font(.title3)
                    .padding(.bottom)
                    
                    ScrollView(showsIndicators: false) {
                        LazyVStack {
                            VStack(alignment: .leading) {
                                Text("Hey iosdev22,")
                                    .font(.title2)
                                Text("Welcome back. ")
                                    .font(.largeTitle)
                                    .foregroundColor(Color("fg"))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            // MARK: Redacted part-1
                            
                            HStack(spacing: 12) {
                                HStack {
                                    Image(systemName: "lock")
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                        .frame(width: 56, height: 56)
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("username")
                                            .font(.subheadline).bold()
                                            .foregroundColor(.black)
                                        Text("User fullname ")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                                Spacer()
                                HStack {
                                    Image(systemName: "lock")
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                        .frame(width: 56, height: 56)
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("username")
                                            .font(.subheadline).bold()
                                            .foregroundColor(.black)
                                        Text("User fullname ")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            .padding(.vertical, 4)
                            .redacted(reason: .placeholder)
                            
                            // MARK: Redacted part-2
                            
                                ForEach(1...7, id:\.self) { item in
                                    VStack(alignment: .leading) {
                                        HStack(alignment: .top, spacing: 12) {
                                            Image(systemName:"lock")
                                                .resizable()
                                                .scaledToFill()
                                                .clipShape(Circle())
                                                .frame(width: 56, height: 56)
                                            
                                            VStack(alignment: .leading, spacing: 4) {
                                                HStack {
                                                    Text("Something user")
                                                        .font(.subheadline).bold()
                                                    Text("username")
                                                        .foregroundColor(.gray)
                                                        .font(.caption)
                                                    Text("2w")
                                                        .foregroundColor(.gray)
                                                        .font(.caption)
                                                }
                                                Text("Wow I've never felt this good in a while. I love my life and my friends!!")
                                                    .font(.subheadline)
                                                    .multilineTextAlignment(.leading)
                                            }
                                        }
                                        HStack {
                                            Image(systemName: "bubble.left")
                                                .font(.subheadline)
                                                .clipShape(Circle())
                                            Spacer()

                                            Image(systemName: "arrow.2.squarepath")
                                                .font(.subheadline)
                                                .clipShape(Circle())
                                            Spacer()
                                            
                                            Image(systemName: "heart")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                                .clipShape(Circle())
                                            Spacer()
                                            
                                            Image(systemName: "bookmark")
                                                .font(.subheadline)
                                                .clipShape(Circle())
                                        }
                                        .padding()
                                        .foregroundColor(.gray)
                                        
                                        Divider()
                                    }
                                    .padding(.vertical, 8)
                                    .redacted(reason: .placeholder)
                                }
                        }
                    }
                    
                    
                    Spacer()
                    
                }
                .padding(.horizontal)
                .edgesIgnoringSafeArea(.bottom)
                .transition(AnyTransition.move(edge: .bottom).animation(.easeInOut))
                .zIndex(1)
            }
            
            if isLoading {
                loadingView.view()
                    .frame(width: 200, height: 200)
                    .onAppear {
                        loadingView.play()
                    }
                    .onDisappear {
                        loadingView.stop()
                    }
                    .transition(AnyTransition.opacity.animation(.easeInOut))
                    .zIndex(2)
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
