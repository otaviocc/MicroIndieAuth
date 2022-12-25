import Foundation

public struct TokenResponse: Decodable {

    // MARK: - Nested types

    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case scope
        case me
    }

    // MARK: - Properties

    public let accessToken: String
    public let scope: String
    public let me: String
}
