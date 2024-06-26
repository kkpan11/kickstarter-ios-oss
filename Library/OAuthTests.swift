import AuthenticationServices
@testable import KsApi
@testable import Library
import XCTest

final class OAuthTests: XCTestCase {
  func verifyRedirectAsync(
    redirectURL url: URL?,
    error: Error?,
    verifier: String,
    verify: @escaping (OAuthAuthorizationResult) -> Void
  ) {
    let expectation = XCTestExpectation(description: "OAuth completion block should be called asynchronously")

    OAuth.handleRedirect(redirectURL: url, error: error, verifier: verifier) { result in

      verify(result)
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 0.01)
  }

  func testHandleRedirect_missingRedirectURL_fails() {
    self.verifyRedirectAsync(redirectURL: nil, error: nil, verifier: "") { result in
      if case .failure = result {
        // Success
      } else {
        XCTFail("Expected call to fail")
      }
    }
  }

  func testHandleRedirect_missingRedirectCodeWithNoCancelParam_fails() {
    self.verifyRedirectAsync(
      redirectURL: URL(string: "ksrauth2://authenticate?foo=bar"),
      error: nil,
      verifier: ""
    ) { result in
      if case .failure = result {
        // Success
      } else {
        XCTFail("Expected call to fail")
      }
    }
  }

  func testHandleRedirect_missingRedirectCodeAndIncludesCancelParam_cancels() {
    self.verifyRedirectAsync(
      redirectURL: URL(string: "ksrauth2://authenticate?canceled=true"),
      error: nil,
      verifier: ""
    ) { result in
      if case .canceled = result {
        // Success
      } else {
        XCTFail("Expected call to be cancelled")
      }
    }
  }

  func testHandleRedirect_cancellationError_cancels() {
    let cancelledError = ASWebAuthenticationSessionError(.canceledLogin)
    self.verifyRedirectAsync(redirectURL: nil, error: cancelledError, verifier: "") { result in
      if case .canceled = result {
        // Success
      } else {
        XCTFail("Expected call to be canceled")
      }
    }
  }

  func testHandleRedirect_anotherError_fails() {
    let anotherError = ASWebAuthenticationSessionError(.presentationContextNotProvided)
    self.verifyRedirectAsync(redirectURL: nil, error: anotherError, verifier: "") { result in
      if case .failure = result {
        // Success
      } else {
        XCTFail("Expected call to fail")
      }
    }
  }

  func testHandleRedirect_validCodeAndVerifier_logsIn() {
    let urlWithCode = URL(string: "ksrauth2://authenticate?code=a1b2c3")

    XCTAssertNil(AppEnvironment.current.currentUser)
    XCTAssertNil(AppEnvironment.current.apiService.oauthToken)

    // The redirect makes two calls - the first is for token exchange, the second fetches the current user.
    let exchangeResponse = OAuthTokenExchangeResponse(token: "test_token")
    var currentUser = User.template
    currentUser.id = 123_456
    let mockService = MockService(fetchUserSelfResponse: currentUser, tokenExchangeResponse: exchangeResponse)

    withEnvironment(apiService: mockService) {
      self.verifyRedirectAsync(redirectURL: urlWithCode, error: nil, verifier: "test_verifier") { result in
        if case .loggedIn = result {
          XCTAssertNotNil(AppEnvironment.current.currentUser)
          XCTAssertEqual(AppEnvironment.current.currentUser?.id, currentUser.id)

          XCTAssertNotNil(AppEnvironment.current.apiService.oauthToken)
          XCTAssertEqual(AppEnvironment.current.apiService.oauthToken?.token, exchangeResponse.token)
        } else {
          XCTFail("Expected call to succeed")
        }
      }
    }
  }

  func testHandleRedirect_exchangeEndpointReturnsError_fails() {
    let urlWithCode = URL(string: "ksrauth2://authenticate?code=a1b2c3")

    XCTAssertNil(AppEnvironment.current.currentUser)
    XCTAssertNil(AppEnvironment.current.apiService.oauthToken)

    // The redirect makes two calls - the first is for token exchange, the second fetches the current user.
    let expectedErrorMessage = "The token exchange failed."
    let exchangeError = ErrorEnvelope(
      errorMessages: [expectedErrorMessage],
      ksrCode: .UnknownCode,
      httpCode: 403,
      exception: nil
    )
    var currentUser = User.template
    currentUser.id = 123_456
    let mockService = MockService(loginError: exchangeError)

    withEnvironment(apiService: mockService) {
      self.verifyRedirectAsync(redirectURL: urlWithCode, error: nil, verifier: "test_verifier") { result in
        if case let .failure(errorMessage: errorMessage) = result {
          XCTAssertNil(AppEnvironment.current.currentUser)
          XCTAssertNil(AppEnvironment.current.apiService.oauthToken)

          XCTAssertEqual(errorMessage, expectedErrorMessage)
        } else {
          XCTFail("Expected call to fail")
        }
      }
    }
  }

  func testHandleRedirect_userEndpointReturnsError_fails() {
    let urlWithCode = URL(string: "ksrauth2://authenticate?code=a1b2c3")

    XCTAssertNil(AppEnvironment.current.currentUser)
    XCTAssertNil(AppEnvironment.current.apiService.oauthToken)

    // The redirect makes two calls - the first is for token exchange, the second fetches the current user.
    let exchangeResponse = OAuthTokenExchangeResponse(token: "test_token")
    let expectedErrorMessage = "Unable to load user."
    let userError = ErrorEnvelope(
      errorMessages: [expectedErrorMessage],
      ksrCode: .UnknownCode,
      httpCode: 403,
      exception: nil
    )
    let mockService = MockService(fetchUserSelfError: userError, tokenExchangeResponse: exchangeResponse)

    withEnvironment(apiService: mockService) {
      self.verifyRedirectAsync(redirectURL: urlWithCode, error: nil, verifier: "test_verifier") { result in
        if case let .failure(errorMessage: errorMessage) = result {
          XCTAssertNil(AppEnvironment.current.currentUser)
          XCTAssertNil(AppEnvironment.current.apiService.oauthToken)

          XCTAssertEqual(errorMessage, expectedErrorMessage)
        } else {
          XCTFail("Expected call to fail")
        }
      }
    }
  }
}
