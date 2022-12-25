import XCTest
@testable import MicroIndieAuth

final class IndieAuthFactoryTests: XCTestCase {

    func testMakeAuthorizationRequest() throws {
        let request = IndieAuthFactory.makeAuthorizationRequest(
            me: "otavio.cc",
            redirectURI: URL(string: "https://indieauth.com/auth")!,
            clientID: "some_client_id",
            state: "1234567890",
            scope: [.create, .delete]
        )

        XCTAssertEqual(
            request.method,
            .get
        )

        XCTAssertEqual(
            request.baseURL,
            URL(string: "https://indieauth.com")
        )

        XCTAssertEqual(
            request.path,
            "/auth"
        )

        XCTAssertEqual(
            request.queryItems.count,
            5
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems.contains(
                    .init(name: "me", value: "otavio.cc")
                )
            )
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems.contains(
                    .init(name: "client_id", value: "some_client_id")
                )
            )
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems.contains(
                    .init(name: "state", value: "1234567890")
                )
            )
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems.contains(
                    .init(name: "scope", value: "create+delete")
                )
            )
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems.contains(
                    .init(name: "response_type", value: "code")
                )
            )
        )
    }

    func testMakeTokenRequest() throws {
        let request = IndieAuthFactory.makeTokenRequest(
            me: "otavio.cc",
            code: "some_code",
            clientID: "some_client_id",
            tokenURI: URL(string: "https://tokens.indieauth.com/token")!,
            redirectURI: URL(string: "app://some_client_id/token")!
        )

        XCTAssertEqual(
            request.method,
            .post
        )

        XCTAssertEqual(
            request.baseURL,
            URL(string: "https://tokens.indieauth.com")
        )

        XCTAssertEqual(
            request.path,
            "/token"
        )

        XCTAssertEqual(
            request.formItems?.count,
            5
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.formItems?.contains(
                    .init(name: "me", value: "otavio.cc")
                )
            )
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.formItems?.contains(
                    .init(name: "grant_type", value: "authorization_code")
                )
            )
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.formItems?.contains(
                    .init(name: "client_id", value: "some_client_id")
                )
            )
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.formItems?.contains(
                    .init(name: "code", value: "some_code")
                )
            )
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.formItems?.contains(
                    .init(
                        name: "redirect_uri",
                        value: "app://some_client_id/token"
                    )
                )
            )
        )
    }
}
