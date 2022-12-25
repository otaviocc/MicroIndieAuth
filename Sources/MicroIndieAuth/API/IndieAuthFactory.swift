import Foundation
import MicroClient

public enum IndieAuthFactory {

    /// Returns the IndieAuth Authorization Request.
    /// The authorization endpoint is responsible for requesting authorization
    /// from the user and generating an authorization code.
    public static func makeAuthorizationRequest(
        me: String,
        redirectURI: URL,
        clientID: String,
        state: String?,
        scope: [IndieAuthScope]?
    ) -> NetworkRequest<VoidRequest, VoidResponse> {
        .init(
            path: redirectURI.path,
            method: .get,
            queryItems: [
                .init(name: "me", value: me),
                .init(name: "client_id", value: clientID),
                .init(name: "state", value: state),
                .init(name: "response_type", value: "code"),
                .init(
                    name: "scope",
                    value: scope?
                        .map { $0.rawValue }
                        .joined(separator: "+")
                )
            ],
            baseURL: redirectURI.makeBaseURL()
        )
    }

    /// Returns the IndieAuth Token Request.
    /// The token endpoint is responsible for issuing access tokens. The client
    /// sends the authorization code obtained in the previous step and expects
    /// to receive an access token in the response.
    public static func makeTokenRequest(
        me: String,
        code: String,
        clientID: String,
        tokenURI: URL,
        redirectURI: URL
    ) -> NetworkRequest<VoidRequest, TokenResponse> {
        .init(
            path: tokenURI.path,
            method: .post,
            queryItems: [
                .init(name: "me", value: me),
                .init(name: "grant_type", value: "authorization_code"),
                .init(name: "client_id", value: clientID),
                .init(name: "code", value: code),
                .init(name: "redirect_uri", value: redirectURI.absoluteString)
            ],
            baseURL: tokenURI.makeBaseURL()
        )
    }
}
