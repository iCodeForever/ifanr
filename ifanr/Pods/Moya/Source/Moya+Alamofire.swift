import Foundation
import Alamofire

<<<<<<< HEAD
public typealias Manager = Alamofire.Manager
internal typealias Request = Alamofire.Request
=======
public typealias Manager = Alamofire.SessionManager
internal typealias Request = Alamofire.Request
internal typealias DownloadRequest = Alamofire.DownloadRequest
internal typealias UploadRequest = Alamofire.UploadRequest
internal typealias DataRequest = Alamofire.DataRequest
internal typealias StreamRequest = Alamofire.StreamRequest

internal typealias URLRequestConvertible = Alamofire.URLRequestConvertible
>>>>>>> b18bd8c21aabb1c63e51708b735d2a09f40b6baf

/// Choice of parameter encoding.
public typealias ParameterEncoding = Alamofire.ParameterEncoding
public typealias JSONEncoding = Alamofire.JSONEncoding
public typealias URLEncoding = Alamofire.URLEncoding
public typealias PropertyListEncoding = Alamofire.PropertyListEncoding

/// Multipart form
public typealias RequestMultipartFormData = Alamofire.MultipartFormData

/// Multipart form data encoding result.
public typealias MultipartFormDataEncodingResult = Manager.MultipartFormDataEncodingResult
public typealias DownloadDestination = Alamofire.DownloadRequest.DownloadFileDestination

/// Multipart form
public typealias RequestMultipartFormData = Alamofire.MultipartFormData

/// Multipart form data encoding result.
public typealias MultipartFormDataEncodingResult = Alamofire.Manager.MultipartFormDataEncodingResult

/// Make the Alamofire Request type conform to our type, to prevent leaking Alamofire to plugins.
extension Request: RequestType { }

/// Internal token that can be used to cancel requests
internal final class CancellableToken: Cancellable, CustomDebugStringConvertible {
    let cancelAction: () -> Void
    let request: Request?
<<<<<<< HEAD
    private(set) var cancelled: Bool = false

    private var lock: dispatch_semaphore_t = dispatch_semaphore_create(1)

    func cancel() {
        dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER)
        defer { dispatch_semaphore_signal(lock) }
=======
    fileprivate(set) var cancelled: Bool = false

    fileprivate var lock: DispatchSemaphore = DispatchSemaphore(value: 1)

    func cancel() {
        _ = lock.wait(timeout: DispatchTime.distantFuture)
        defer { lock.signal() }
>>>>>>> b18bd8c21aabb1c63e51708b735d2a09f40b6baf
        guard !cancelled else { return }
        cancelled = true
        cancelAction()
    }

<<<<<<< HEAD
    init(action: () -> Void) {
=======
    init(action: @escaping () -> Void) {
>>>>>>> b18bd8c21aabb1c63e51708b735d2a09f40b6baf
        self.cancelAction = action
        self.request = nil
    }

    init(request: Request) {
        self.request = request
        self.cancelAction = {
            request.cancel()
        }
    }

    var debugDescription: String {
        guard let request = self.request else {
            return "Empty Request"
        }
        return request.debugDescription
    }

}
