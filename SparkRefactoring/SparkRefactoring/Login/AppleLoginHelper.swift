//
//  AppleLoginHelper.swift
//  SparkRefactoring
//
//  Created by Hanteo on 2021/01/22.
//

import Foundation
import AuthenticationServices

protocol LoginDelegate: class {
    func login(userIdentifier: String, name: String)
}

class AppleLoginHelper: NSObject {
    weak var loginDelegate: LoginDelegate?
    
    static let shared = AppleLoginHelper()
    
    deinit {
        print("AppleLoginHelper deinit")
    }
    
    func setDelegate(_ loginDelegate: LoginDelegate) {
        self.loginDelegate = loginDelegate
    }
    
    func handleAppleIDRequest() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName]
        let authorizatinoController = ASAuthorizationController(authorizationRequests: [request])
        authorizatinoController.delegate = self
        //authorizatinoController.perfor
    }
}

extension AppleLoginHelper: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let name = (appleIDCredential.fullName?.familyName ?? "") + (appleIDCredential.fullName?.givenName ?? "")
            self.loginDelegate?.login(userIdentifier: userIdentifier, name: name)
        }
    }
}
