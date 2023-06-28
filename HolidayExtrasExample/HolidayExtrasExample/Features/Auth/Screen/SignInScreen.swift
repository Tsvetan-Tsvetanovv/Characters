//
//  SignInScreen.swift
//  HolidayExtrasExample
//
//  Created by Tsvetan Tsvetanov on 28.06.23.
//

import SwiftUI


struct SignInScreen: View {

    @ObservedObject private var viewModel: SignInViewModel
    @FocusState private var focusedField: SignInViewModel.SignInField?

    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Form {
                Section {
                    emailTextField
                    passwordTextField
                } footer: {
                    sectionFooterText
                }

                Section {
                    submitButton
                }
                .disabled(viewModel.isSubmitButtonDisabled)
            }

            footerText
                .padding()
        }
        .autocorrectionDisabled()
        .textInputAutocapitalization(.never)
        .navigationTitle("Sign In")
        .onReceive(viewModel.$focusedField) { field in
            focusedField = field
        }
    }
}

private extension SignInScreen {

    var emailTextField: some View {
        TextField(
            "E-mail",
            text: $viewModel.email,
            prompt: Text("E-mail")
        )
        .focused($focusedField, equals: .email)
        .textContentType(.emailAddress)
        .keyboardType(.emailAddress)
        .onSubmit {
            viewModel.submit(.email)
        }
    }

    var passwordTextField: some View {
        SecureField(
            "Password",
            text: $viewModel.password,
            prompt: Text("Password")
        )
        .focused($focusedField, equals: .password)
        .textContentType(.password)
        .onSubmit {
            viewModel.submit(.password)
        }
        .submitLabel(.done)
    }

    var sectionFooterText: some View {
        Text("Please enter a pair of email and password.")
    }

    var submitButton: some View {
        Button("Sign in") {
            viewModel.signIn()
        }
    }

    var footerText: some View {
        HStack(spacing: 5) {
            Text("Don't have an account?")
            Button("Sign up") {
                viewModel.didTapSignUp()
            }
        }
    }
}
