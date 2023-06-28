//
//  SignInViewModel.swift
//  HolidayExtrasExample
//
//  Created by Tsvetan Tsvetanov on 28.06.23.
//

import Foundation
import Combine

final class SignInViewModel: ObservableObject {

    enum SignInField {
        case email
        case password
    }

    private weak var signInCoordinating: SignInCoordinating?

    @Published var focusedField: SignInField? = nil
    @Published private(set) var isSubmitButtonDisabled: Bool = true

    @Published var email: String = ""
    @Published var password: String = ""

    private var signInTask: Task<Void, Never>?
    private var cancellables = Set<AnyCancellable>()

    private var isValid: Bool {
        !email.isEmpty && !password.isEmpty
    }

    init(signInCoordinating: SignInCoordinating) {
        self.signInCoordinating = signInCoordinating

        bind()
    }

    func submit(_ field: SignInField) {
        switch field {
        case .email:
            focusedField = .password
        case .password:
            guard isValid else {
                focusedField = nil
                return
            }
            signIn()
        }
    }

    func signIn() {
        signInCoordinating?.signIn()
    }

    func didTapSignUp() {
        signInCoordinating?.requestSignUp()
    }

    private func bind() {
        Publishers.CombineLatest($email, $password)
            .debounce(for: .seconds(0.3), scheduler: RunLoop.main)
            .sink { [weak self] _, _ in
                guard let self else { return }

                self.isSubmitButtonDisabled = !self.isValid
            }
            .store(in: &cancellables)
    }
}
