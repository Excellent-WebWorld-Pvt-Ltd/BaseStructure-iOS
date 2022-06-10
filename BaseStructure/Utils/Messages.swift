//
//  Messages.swift
//  Populaw
//
//  Created by Gaurang on 09/09/21.
//

import Foundation
// swiftlint:disable line_length
enum Messages {
    static let somethingWentWrong = "Something went wrong"
    static let noInternetConnection = "Internet not available, Please check your network connection."
    static let sessionExpired = "Session expired, Please log in again"
    static let cameraAccess = "Unable to access the Camera"
    static let cameraAccessMsg = "To enable access, go to Settings > Privacy > Camera and turn on Camera access for this app."
    static let photoAccess = "Unable to access the Photos"
    static let photoAccessMsg = "To enable access, go to Settings > Privacy > Photos and turn on Photos access for this app."
    static let chooseSource = "Choose A Source"

    // validation
    static let emptyEmail = "Please enter email"
    static let invalidEmail = "Please enter valid email"
    static let emptyPassword = "Please enter password"
    static let emptyConfirmPassword = "Please enter confirm password"
    static let confirmPasswordError = "Password and confirm password does not match"
    static let emptyFirstName = "Please enter first name"
    static let emptyLastName = "Please enter last name"
    static let emptyFullName = "Please enter full name"
    static let pleaseEnter = "Please Enter"
    static let pleaseEnterValid = "Please Enter valid"
    static let specialCharacterNotAllowed = "Sorry! special characters are not allowed in"
    static let invalidUsernameRange = "Username must be between 8 and 18 characters"
    static let invalidPasswordRange = "Password must be between 8 and 25 characters"
}
// swiftlint:enable line_length
