import Foundation

extension URL {

    func makeBaseURL() -> URL? {
        var components = URLComponents()

        components.scheme = scheme
        components.host = host

        return components.url
    }
}
