import OSLog

extension Logger {
    private static var subsystem: String? {
        return Bundle.main.bundleIdentifier
    }

    static let network: Logger = {
        return Logger(subsystem: subsystem ?? "no bundleIdentifier", category: "api-errors")
    }()
}
