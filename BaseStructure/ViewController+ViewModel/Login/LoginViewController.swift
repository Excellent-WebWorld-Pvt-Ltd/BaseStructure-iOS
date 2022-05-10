//
//  LoginViewController.swift
//  BaseStructure
//
//  Created by Gaurang on 28/04/22.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var loginButton: ThemeAnimatedButton!
    private var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewModelEvent()
    }
    
    private func observeViewModelEvent() {
        viewModel.event.bind { [weak self] event in
            guard let self = self else {
                return
            }
            switch event {
            case .idle:
                break
            case .loading:
                self.loginButton.showLoading()
            case .stopLoading:
                self.loginButton.hideLoading()
            case .error(let message, let retryCallback):
                self.showErrorMessage(message, onRetry: retryCallback)
            case .loggedIn:
                AppDelegate.current?.setRootViewController()
            }
        }
    }
    
    @IBAction func login() {
        self.viewModel.doLogin()
    }
}
