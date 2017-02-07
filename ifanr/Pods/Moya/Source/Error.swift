import Foundation

<<<<<<< HEAD
public enum Error: ErrorType {
    case ImageMapping(Response)
    case JSONMapping(Response)
    case StringMapping(Response)
    case StatusCode(Response)
    case Data(Response)
    case Underlying(NSError)
=======
public enum Error: Swift.Error {
    case imageMapping(Response)
    case jsonMapping(Response)
    case stringMapping(Response)
    case statusCode(Response)
    case data(Response)
    case underlying(Swift.Error)
>>>>>>> b18bd8c21aabb1c63e51708b735d2a09f40b6baf
}

public extension Moya.Error {
    /// Depending on error type, returns a `Response` object.
    var response: Moya.Response? {
        switch self {
<<<<<<< HEAD
        case .ImageMapping(let response): return response
        case .JSONMapping(let response): return response
        case .StringMapping(let response): return response
        case .StatusCode(let response): return response
        case .Data(let response): return response
        case .Underlying: return nil
=======
        case .imageMapping(let response): return response
        case .jsonMapping(let response): return response
        case .stringMapping(let response): return response
        case .statusCode(let response): return response
        case .data(let response): return response
        case .underlying: return nil
>>>>>>> b18bd8c21aabb1c63e51708b735d2a09f40b6baf
        }
    }
}
