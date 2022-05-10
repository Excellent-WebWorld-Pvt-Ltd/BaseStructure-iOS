//
//  LoginViewModel.swift
//  BaseStructure
//
//  Created by Gaurang on 05/05/22.
//

import Foundation

class LoginViewModel {
    let event = Observable<Event>(value: .idle)
    
    func doLogin() {
        self.event.set(.loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.event.set(.stopLoading)
            SessionManager.shared.doLogin(userId: "1", xApiKey: "14bc774791d9d20b3a138bb6e26e2579")
            self.event.set(.loggedIn)
        }
    }
}

extension LoginViewModel {
    enum Event {
        case idle
        case loading
        case stopLoading
        case error(message: String, retryCallback: EmptyClosure?)
        case loggedIn
    }
}
