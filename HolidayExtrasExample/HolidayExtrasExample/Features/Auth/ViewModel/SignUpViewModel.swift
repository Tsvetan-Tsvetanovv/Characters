//
//  SignUpViewModel.swift
//  HolidayExtrasExample
//
//  Created by Tsvetan Tsvetanov on 28.06.23.
//

import Foundation
import Combine

final class SignUpViewModel: ObservableObject {

    enum SignUpField {
        case name
        case email
        case password
        case confirmPassword
    }

    @Published private(set) var isSubmitButtonDisabled: Bool = true
    @Published private(set) var focusedField: SignUpField?

    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""

    private weak var signUpCoordinating: SignUpCoordinating?

    private var signUpTask: Task<Void, Never>?
    private var cancellables = Set<AnyCancellable>()

    private var isValid: Bool {
        !name.isEmpty && !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty
    }

    init(signUpCoordinating: SignUpCoordinating) {
        self.signUpCoordinating = signUpCoordinating

        bind()
    }

    func signUp() {
        signUpCoordinating?.signUp()
    }

    func didTapSignIn() {
        signUpCoordinating?.requestSignIn()
    }

    func submit(_ field: SignUpField) {
        switch field {
        case .name:
            focusedField = .email
        case .email:
            focusedField = .password
        case .password:
            focusedField = .confirmPassword
        case .confirmPassword:
            guard isValid else {
                focusedField = nil
                return
            }
            signUp()
        }
    }

    private func bind() {
        Publishers.CombineLatest4($name, $email, $password, $confirmPassword)
            .debounce(for: .seconds(0.3), scheduler: RunLoop.main)
            .sink { [weak self] name, email, password, confirmPassword in
                guard let self else { return }

                self.isSubmitButtonDisabled = !self.isValid
            }
            .store(in: &cancellables)
    }
}
