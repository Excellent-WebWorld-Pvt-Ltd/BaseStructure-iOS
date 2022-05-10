//
//  ViewModel.swift
//  Router
//
//  Created by Gaurang on 27/04/22.
//

import Foundation

class BaseViewModel: BaseViewModelProtocol {
    var eventHandler: ((BaseViewModelChange) -> Void)?
    func startSynching() {
        
    }
}

protocol BaseViewModelProtocol {
    var eventHandler: ((_ event: BaseViewModelChange) -> Void)? { get set }
    func startSynching()
}

extension BaseViewModelProtocol {
    func emit(_ change: BaseViewModelChange) {
        eventHandler?(change)
    }
}

enum BaseViewModelChange {
    case loading
    case updateDataModel
    case error(message: String, retryCallback: EmptyClosure?)
}
