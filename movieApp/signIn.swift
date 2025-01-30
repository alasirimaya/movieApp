//
//  signIn.swift
//  movieApp
//
//  Created by maya alasiri  on 19/07/1446 AH.
//
import SwiftUI

// MARK: - Model
struct SignInModel {
    var email: String = ""
    var password: String = ""
}

// MARK: - ViewModel
class SignInViewModel: ObservableObject {
    @Published var model = SignInModel()
    @Published var isPasswordHidden = true
}

// MARK: - Which field is focused?
enum Field {
    case email
    case password
}

// MARK: - View
struct signIn: View {
    @ObservedObject var viewModel: SignInViewModel
    @FocusState private var focusedField: Field?

    private var isFormFilled: Bool {
        !viewModel.model.email.isEmpty && !viewModel.model.password.isEmpty
    }

    @State private var navigateToContentView = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                Image("Sign in background")
                    .resizable()
                    .ignoresSafeArea()
                    .offset(x: -0.5, y: -130)

                Image("The linear layer")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Sign in")
                            .font(.system(size: 42, weight: .bold))
                            .foregroundColor(.white)

                        Text("You'll find what you're looking for in the ocean of movies")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                    }
                    .offset(x: 1, y: 455)
                    .padding(.bottom, 448)

                    // Email input
                    Text("Email")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(customGray())
                        .padding(.bottom, 4)

                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(color838383())
                            .frame(height: 40)

                        RoundedRectangle(cornerRadius: 8)
                            .stroke(focusedField == .email ? colorF3CC4F() : .clear, lineWidth: 2)
                            .frame(height: 40)

                        TextField("Enter your email", text: $viewModel.model.email)
                            .foregroundColor(.white)
                            .accentColor(colorF3CC4F())
                            .padding(.horizontal, 10)
                            .focused($focusedField, equals: .email)
                    }

                    // Password input
                    Text("Password")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(customGray())
                        .padding(.top, 4)

                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(color838383())
                            .frame(height: 40)

                        RoundedRectangle(cornerRadius: 8)
                            .stroke(focusedField == .password ? colorF3CC4F() : .clear, lineWidth: 2)
                            .frame(height: 40)

                        HStack {
                            if viewModel.isPasswordHidden {
                                SecureField("", text: $viewModel.model.password)
                                    .foregroundColor(.white)
                                    .accentColor(colorF3CC4F())
                                    .padding(.horizontal, 10)
                                    .focused($focusedField, equals: .password)
                            } else {
                                TextField("", text: $viewModel.model.password)
                                    .foregroundColor(.white)
                                    .accentColor(colorF3CC4F())
                                    .padding(.horizontal, 10)
                                    .focused($focusedField, equals: .password)
                            }

                            Spacer()

                            Image(systemName: viewModel.isPasswordHidden ? "eye.slash" : "eye")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(customGray())
                                .padding(.trailing, 10)
                                .onTapGesture {
                                    viewModel.isPasswordHidden.toggle()
                                }
                        }
                    }

                    Spacer()
                }
                .offset(x: 1, y: 90)
                .padding(.horizontal, 24)

                // Sign-in button
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(isFormFilled ? colorF3CC4F() : customGray())
                        .frame(width: 358, height: 45)
                        .cornerRadius(8)
                        .overlay(
                            Text("Sign in")
                                .foregroundColor(isFormFilled ? .black : color838383())
                                .font(.system(size: 18, weight: .semibold))
                        )
                        .onTapGesture {
                            if isFormFilled {
                                focusedField = nil
                                navigateToContentView = true
                            }
                        }
                        .disabled(!isFormFilled)
                }
                .offset(x: 1, y: 378)
            }
            .navigationDestination(isPresented: $navigateToContentView) {
                ContentView()
            }
        }
    }
}

    // MARK: - Color Helpers
    
    /// #CDCDCD
    private func customGray() -> Color {
        Color(red: 205 / 255, green: 205 / 255, blue: 205 / 255)
    }
    
    /// #3D3D3D
    private func color838383() -> Color {
        Color(red: 61 / 255, green: 61 / 255, blue: 61 / 255)
    }
    
    /// #595959
    private func color595959() -> Color {
        Color(red: 89 / 255, green: 89 / 255, blue: 89 / 255)
    }
    
    /// #F3CC4F
    private func colorF3CC4F() -> Color {
        Color(red: 243 / 255, green: 204 / 255, blue: 79 / 255)
    }


// MARK: - Preview
#Preview {
    let viewModel = SignInViewModel()
    return signIn(viewModel: viewModel)
}


////  Text("Email")
//.font(.system(size:15))
//.foregroundColor(customGray())
