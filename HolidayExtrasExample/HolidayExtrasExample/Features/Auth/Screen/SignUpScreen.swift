//
//  SignUpScreen.swift
//  HolidayExtrasExample
//
//  Created by Tsvetan Tsvetanov on 28.06.23.
//

import SwiftUI

struct SignUpScreen: View {

    @ObservedObject private var viewModel: SignUpViewModel
    @FocusState private var focusedField: SignUpViewModel.SignUpField?

    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Form {
                Section {
                    nameTextField
                    emailTextField
                    passwordTextField
                    confirmPasswordTextField
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
        .navigationTitle("Sign Up")
        .onReceive(viewModel.$focusedField) { field in
            focusedField = field
        }
    }
}

private extension SignUpScreen {

    var nameTextField: some View {
        TextField(
            "Name",
            text: $viewModel.name,
            prompt: Text("Name")
        )
        .focused($focusedField, equals: .name)
        .textContentType(.name)
        .onSubmit {
            viewModel.submit(.name)
        }
    }

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
    }

    var confirmPasswordTextField: some View {
        SecureField(
            "Confirm Password",
            text: $viewModel.confirmPassword,
            prompt: Text("Confirm Password")
        )
        .focused($focusedField, equals: .confirmPassword)
        .textContentType(.password)
        .submitLabel(.done)
        .onSubmit {
            viewModel.submit(.confirmPassword)
        }
    }

    var sectionFooterText: some View {
        Text("Please fill up the form in order to create an account.")
    }

    var submitButton: some View {
        Button("Create account") {
            viewModel.signUp()
        }
    }

    var footerText: some View {
        HStack(spacing: 5) {
            Text("Already got an account?")
            Button("Sign in") {
                viewModel.didTapSignIn()
            }
        }
    }
}
