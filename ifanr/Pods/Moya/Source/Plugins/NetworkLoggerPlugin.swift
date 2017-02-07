import Foundation
import Result

/// Logs network activity (outgoing requests and incoming responses).
public final class NetworkLoggerPlugin: PluginType {
<<<<<<< HEAD
    private let loggerId = "Moya_Logger"
    private let dateFormatString = "dd/MM/yyyy HH:mm:ss"
    private let dateFormatter = NSDateFormatter()
    private let separator = ", "
    private let terminator = "\n"
    private let cURLTerminator = "\\\n"
    private let output: (items: Any..., separator: String, terminator: String) -> Void
    private let responseDataFormatter: ((NSData) -> (NSData))?
=======
    fileprivate let loggerId = "Moya_Logger"
    fileprivate let dateFormatString = "dd/MM/yyyy HH:mm:ss"
    fileprivate let dateFormatter = DateFormatter()
    fileprivate let separator = ", "
    fileprivate let terminator = "\n"
    fileprivate let cURLTerminator = "\\\n"
    fileprivate let output: (_ seperator: String, _ terminator: String, _ items: Any...) -> Void
    fileprivate let responseDataFormatter: ((Data) -> (Data))?
>>>>>>> b18bd8c21aabb1c63e51708b735d2a09f40b6baf

    /// If true, also logs response body data.
    public let verbose: Bool
    public let cURL: Bool

<<<<<<< HEAD
    public init(verbose: Bool = false, cURL: Bool = false, output: (items: Any..., separator: String, terminator: String) -> Void = print, responseDataFormatter: ((NSData) -> (NSData))? = nil) {
=======
    public init(verbose: Bool = false, cURL: Bool = false, output: @escaping (_ seperator: String, _ terminator: String, _ items: Any...) -> Void = NetworkLoggerPlugin.reversedPrint, responseDataFormatter: ((Data) -> (Data))? = nil) {
>>>>>>> b18bd8c21aabb1c63e51708b735d2a09f40b6baf
        self.cURL = cURL
        self.verbose = verbose
        self.output = output
        self.responseDataFormatter = responseDataFormatter
    }

<<<<<<< HEAD
    public func willSendRequest(request: RequestType, target: TargetType) {
        if let request = request as? CustomDebugStringConvertible where cURL {
            output(items: request.debugDescription, separator: separator, terminator: terminator)
            return
        }
        outputItems(logNetworkRequest(request.request))
=======
    public func willSendRequest(_ request: RequestType, target: TargetType) {
        if let request = request as? CustomDebugStringConvertible, cURL {
            output(separator, terminator, request.debugDescription)
            return
        }
        outputItems(logNetworkRequest(request.request as URLRequest?))
>>>>>>> b18bd8c21aabb1c63e51708b735d2a09f40b6baf
    }

    public func didReceiveResponse(_ result: Result<Moya.Response, Moya.Error>, target: TargetType) {
        if case .success(let response) = result {
            outputItems(logNetworkResponse(response.response, data: response.data, target: target))
        } else {
            outputItems(logNetworkResponse(nil, data: nil, target: target))
        }
    }

<<<<<<< HEAD
    private func outputItems(items: [String]) {
=======
    fileprivate func outputItems(_ items: [String]) {
>>>>>>> b18bd8c21aabb1c63e51708b735d2a09f40b6baf
        if verbose {
            items.forEach { output(separator, terminator, $0) }
        } else {
            output(separator, terminator, items)
        }
    }
}

private extension NetworkLoggerPlugin {

    var date: String {
        dateFormatter.dateFormat = dateFormatString
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: Date())
    }

    func format(_ loggerId: String, date: String, identifier: String, message: String) -> String {
        return "\(loggerId): [\(date)] \(identifier): \(message)"
    }

<<<<<<< HEAD
    func logNetworkRequest(request: NSURLRequest?) -> [String] {
=======
    func logNetworkRequest(_ request: URLRequest?) -> [String] {
>>>>>>> b18bd8c21aabb1c63e51708b735d2a09f40b6baf

        var output = [String]()

        output += [format(loggerId, date: date, identifier: "Request", message: request?.description ?? "(invalid request)")]

        if let headers = request?.allHTTPHeaderFields {
            output += [format(loggerId, date: date, identifier: "Request Headers", message: headers.description)]
        }

        if let bodyStream = request?.httpBodyStream {
            output += [format(loggerId, date: date, identifier: "Request Body Stream", message: bodyStream.description)]
        }

        if let httpMethod = request?.httpMethod {
            output += [format(loggerId, date: date, identifier: "HTTP Request Method", message: httpMethod)]
        }

        if let body = request?.httpBody, verbose == true {
            if let stringOutput = NSString(data: body, encoding: String.Encoding.utf8.rawValue) as? String {
                output += [format(loggerId, date: date, identifier: "Request Body", message: stringOutput)]
            }
        }

        return output
    }

    func logNetworkResponse(_ response: URLResponse?, data: Data?, target: TargetType) -> [String] {
        guard let response = response else {
           return [format(loggerId, date: date, identifier: "Response", message: "Received empty network response for \(target).")]
        }

        var output = [String]()

        output += [format(loggerId, date: date, identifier: "Response", message: response.description)]

<<<<<<< HEAD
        if let data = data where verbose == true {
            if let stringData = String(data: responseDataFormatter?(data) ?? data, encoding: NSUTF8StringEncoding) {
=======
        if let data = data, verbose == true {
            if let stringData = String(data: responseDataFormatter?(data) ?? data, encoding: String.Encoding.utf8) {
>>>>>>> b18bd8c21aabb1c63e51708b735d2a09f40b6baf
                output += [stringData]
            }
        }

        return output
    }
}

fileprivate extension NetworkLoggerPlugin {
    static func reversedPrint(seperator: String, terminator: String, items: Any...) {
        print(items, separator: seperator, terminator: terminator)
    }
}
