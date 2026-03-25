import Foundation
import Combine

@MainActor
class RefreshLogger: ObservableObject {
    static let shared = RefreshLogger()

    @Published var logs: String = ""
    private let maxLines = 200

    private init() {}

    func log(_ message: String) {
        let timestamp = Self.formatter.string(from: Date())
        let line = "[\(timestamp)] \(message)"
        print(line)
        if !logs.isEmpty { logs += "\n" }
        logs += line
        trimIfNeeded()
    }

    func clear() {
        logs = ""
    }

    private func trimIfNeeded() {
        let lines = logs.components(separatedBy: "\n")
        if lines.count > maxLines {
            logs = lines.suffix(maxLines).joined(separator: "\n")
        }
    }

    private static let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "HH:mm:ss.SSS"
        return f
    }()
}
