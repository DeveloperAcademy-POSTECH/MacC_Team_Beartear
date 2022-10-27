//
//  AppleLoginManager.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/10/26.
//
import AuthenticationServices
import CryptoKit

import FirebaseAuth

protocol AppleLoginManagerDelegate: AnyObject {
    func appleLoginSuccess(authResult: AuthDataResult?)
    func appleLoginFail()
}

final class AppleLoginManager: NSObject {
    private var currentNonce: String?
    weak var viewController: UIViewController?
    weak var delegate: AppleLoginManagerDelegate?

    init(vc: UIViewController) {
        self.viewController = vc
    }

    func startSignInWithAppleFlow() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    // 로그아웃
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            // TODO: keychain에서 제거
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }

    // 탈퇴 (withdrwal)
    func withDrawal() {
        let user = Auth.auth().currentUser
        user?.delete { error in
          if let error = error {
            print("Error withdrawal: %@", error)
          } else {
              // TODO: keychain에서 제거
          }
        }
    }

    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length

        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError(
                        "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                    )
                }
                return random
            }

            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }

                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }

        return result
    }

    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }
}

// MARK: - ASAuthorizationControllerDelegate

extension AppleLoginManager: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIdCredential.identityToken else {
                print("Unable to fetch identity token")
                                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }

            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                            rawNonce: nonce)
            Auth.auth().signIn(with: credential) { [self] authResult, error in
                if let error = error {
                    print("Error Apple sign in: %@", error)
                    return
                }
                delegate?.appleLoginSuccess(authResult: authResult)
            }
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        delegate?.appleLoginFail()
    }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding

extension AppleLoginManager: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return viewController!.view.window!
    }
}
