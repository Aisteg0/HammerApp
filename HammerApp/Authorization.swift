//
//  Authorization.swift
//  HammerApp
//
//  Created by Михаил Ганин on 23.07.2025.
//

import SwiftUI

struct Authorization: View {
    private let correctLogin = "йцу"
    private let correctPassword = "йцу"
    
    @State private var login: String = ""
    @State private var password: String = ""
    @State private var showErrorAlert: Bool = false
    @State private var showMenuView: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Авторизация")
            Spacer()
                .frame(height: 217)
            Image("ToPizza")
            
            TextField("Логин", text: $login)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 343, height: 50)
                .padding(.horizontal)
                .autocapitalization(.none)
                .cornerRadius(20)
            
            SecureField("Пароль", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 343, height: 50)
                .padding(.horizontal)
                .cornerRadius(20)
            
            Text("Неверный логин или пароль")
                .foregroundColor(.red)
                .opacity(showErrorAlert ? 1 : 0)
            
            Spacer()
            
            Button(action: attemptLogin) {
                Text("Войти")
                    .frame(width: 343, height: 50)
                    .background(Color(red: 253/255, green: 58/255, blue: 105/255))
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .padding(.horizontal)
            .alert(isPresented: $showErrorAlert) {
                Alert(
                    title: Text("Ошибка"),
                    message: Text("Введены неверные учетные данные"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .background(Color(red: 243/255, green: 245/255, blue: 249/255))
        .fullScreenCover(isPresented: $showMenuView) {
            MenuView()
        }
    }
    
    private func attemptLogin() {
        if login == correctLogin && password == correctPassword {
            showMenuView = true
        } else {
            showErrorAlert = true
        }
    }
}

#Preview {
    Authorization()
}
