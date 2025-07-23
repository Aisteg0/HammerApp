//
//  Authorization.swift
//  HammerApp
//
//  Created by Михаил Ганин on 23.07.2025.
//

import SwiftUI

struct Authorization: View {
    // Хардкодные учетные данные
    private let correctLogin = "йцу"
    private let correctPassword = "йцу"
    
    // Состояния для полей ввода
    @State private var login: String = ""
    @State private var password: String = ""
    @State private var showErrorAlert: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            // Заголовок
            Text("Авторизация")
            Spacer()
                .frame(height: 217)
            Image("ToPizza")
            
            // Поле для логина
            TextField("Логин", text: $login)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 343, height: 50)
                .padding(.horizontal)
                .autocapitalization(.none)
                .cornerRadius(20)
            
            // Поле для пароля
            SecureField("Пароль", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 343, height: 50)
                .padding(.horizontal)
                .cornerRadius(20)
            
            // Сообщение об ошибке (появляется только при ошибке)
            Text("Неверный логин или пароль")
                .foregroundColor(.red)
                .opacity(showErrorAlert ? 1 : 0)
            Spacer()
            // Кнопка входа
            Button(action: attemptLogin) {
                Text("Войти")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 253.255, green: 58/255, blue: 105/255))
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
            
//            Spacer()
        }
        .background(Color(red: 243/255, green: 245/255, blue: 249/255))
    }
        
    
    // Функция проверки учетных данных
    private func attemptLogin() {
        if login == correctLogin && password == correctPassword {
            // Успешный вход (здесь можно добавить навигацию)
            print("Успешный вход!")
        } else {
            showErrorAlert = true
        }
    }
}

#Preview {
    Authorization()
}
