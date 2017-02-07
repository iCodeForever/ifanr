import Foundation
import Result

/// Provides each request with optional NSURLCredentials.
public final class CredentialsPlugin: PluginType {

    public typealias CredentialClosure = (TargetType) -> URLCredential?
    let credentialsClosure: CredentialClosure

    public init(credentialsClosure: @escaping CredentialClosure) {
        self.credentialsClosure = credentialsClosure
    }

    // MARK: Plugin

<<<<<<< HEAD
    public func willSendRequest(request: RequestType, target: TargetType) {
=======
    public func willSendRequest(_ request: RequestType, target: TargetType) {
>>>>>>> b18bd8c21aabb1c63e51708b735d2a09f40b6baf
        if let credentials = credentialsClosure(target) {
            _ = request.authenticate(usingCredential: credentials)
        }
    }

<<<<<<< HEAD
    public func didReceiveResponse(result: Result<Moya.Response, Moya.Error>, target: TargetType) {
=======
    public func didReceiveResponse(_ result: Result<Moya.Response, Moya.Error>, target: TargetType) {
>>>>>>> b18bd8c21aabb1c63e51708b735d2a09f40b6baf

    }
}
