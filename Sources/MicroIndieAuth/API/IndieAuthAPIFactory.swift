import Foundation
import MicroClient

public protocol IndieAuthAPIFactoryProtocol {

    func makeIndieAuthAPIClient(
        baseURL: URL
    ) -> NetworkClientProtocol
}

public struct IndieAuthAPIFactory: IndieAuthAPIFactoryProtocol {

    // MARK: - Life cycle

    public init() {}

    // MARK: - Public

    public func makeIndieAuthAPIClient(
        baseURL: URL
    ) -> MicroClient.NetworkClientProtocol {
        let configuration = makeAPIConfiguration(
            baseURL: baseURL
        )

        return NetworkClient(
            configuration: configuration
        )
    }
}

// MARK: - Private

private func makeAPIConfiguration(
    baseURL: URL
) -> NetworkConfiguration {
    .init(
        session: .shared,
        defaultDecoder: JSONDecoder(),
        defaultEncoder: JSONEncoder(),
        baseURL: baseURL
    )
}
