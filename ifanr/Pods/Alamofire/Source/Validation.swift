//
//  Validation.swift
//
//  Copyright (c) 2014-2016 Alamofire Software Foundation (http://alamofire.org/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

extension Request {

<<<<<<< HEAD
    /**
        Used to represent whether validation was successful or encountered an error resulting in a failure.

        - Success: The validation was successful.
        - Failure: The validation failed encountering the provided error.
    */
    public enum ValidationResult {
        case Success
        case Failure(NSError)
    }

    /**
        A closure used to validate a request that takes a URL request and URL response, and returns whether the
        request was valid.
    */
    public typealias Validation = (NSURLRequest?, NSHTTPURLResponse) -> ValidationResult

    /**
        Validates the request, using the specified closure.

        If validation fails, subsequent calls to response handlers will have an associated error.

        - parameter validation: A closure to validate the request.

        - returns: The request.
    */
    public func validate(validation: Validation) -> Self {
        delegate.queue.addOperationWithBlock {
            if let
                response = self.response where self.delegate.error == nil,
                case let .Failure(error) = validation(self.request, response)
            {
                self.delegate.error = error
            }
        }

        return self
    }

    // MARK: - Status Code

    /**
        Validates that the response has a status code in the specified range.

        If validation fails, subsequent calls to response handlers will have an associated error.
=======
    // MARK: Helper Types
>>>>>>> b18bd8c21aabb1c63e51708b735d2a09f40b6baf

    fileprivate typealias ErrorReason = AFError.ResponseValidationFailureReason

<<<<<<< HEAD
        - returns: The request.
    */
    public func validate<S: SequenceType where S.Generator.Element == Int>(statusCode acceptableStatusCode: S) -> Self {
        return validate { _, response in
            if acceptableStatusCode.contains(response.statusCode) {
                return .Success
            } else {
                let failureReason = "Response status code was unacceptable: \(response.statusCode)"

                let error = NSError(
                    domain: Error.Domain,
                    code: Error.Code.StatusCodeValidationFailed.rawValue,
                    userInfo: [
                        NSLocalizedFailureReasonErrorKey: failureReason,
                        Error.UserInfoKeys.StatusCode: response.statusCode
                    ]
                )

                return .Failure(error)
            }
        }
=======
    /// Used to represent whether validation was successful or encountered an error resulting in a failure.
    ///
    /// - success: The validation was successful.
    /// - failure: The validation failed encountering the provided error.
    public enum ValidationResult {
        case success
        case failure(Error)
>>>>>>> b18bd8c21aabb1c63e51708b735d2a09f40b6baf
    }

    fileprivate struct MIMEType {
        let type: String
        let subtype: String

        var isWildcard: Bool { return type == "*" && subtype == "*" }

        init?(_ string: String) {
            let components: [String] = {
                let stripped = string.trimmingCharacters(in: .whitespacesAndNewlines)
                let split = stripped.substring(to: stripped.range(of: ";")?.lowerBound ?? stripped.endIndex)
                return split.components(separatedBy: "/")
            }()

            if let type = components.first, let subtype = components.last {
                self.type = type
                self.subtype = subtype
            } else {
                return nil
            }
        }

        func matches(_ mime: MIMEType) -> Bool {
            switch (type, subtype) {
            case (mime.type, mime.subtype), (mime.type, "*"), ("*", mime.subtype), ("*", "*"):
                return true
            default:
                return false
            }
        }
    }

    // MARK: Properties

    fileprivate var acceptableStatusCodes: [Int] { return Array(200..<300) }

    fileprivate var acceptableContentTypes: [String] {
        if let accept = request?.value(forHTTPHeaderField: "Accept") {
            return accept.components(separatedBy: ",")
        }

<<<<<<< HEAD
        - returns: The request.
    */
    public func validate<S: SequenceType where S.Generator.Element == String>(contentType acceptableContentTypes: S) -> Self {
        return validate { _, response in
            guard let validData = self.delegate.data where validData.length > 0 else { return .Success }
=======
        return ["*/*"]
    }
>>>>>>> b18bd8c21aabb1c63e51708b735d2a09f40b6baf

    // MARK: Status Code

    fileprivate func validate<S: Sequence>(
        statusCode acceptableStatusCodes: S,
        response: HTTPURLResponse)
        -> ValidationResult
        where S.Iterator.Element == Int
    {
        if acceptableStatusCodes.contains(response.statusCode) {
            return .success
        } else {
            let reason: ErrorReason = .unacceptableStatusCode(code: response.statusCode)
            return .failure(AFError.responseValidationFailed(reason: reason))
        }
    }

    // MARK: Content Type

    fileprivate func validate<S: Sequence>(
        contentType acceptableContentTypes: S,
        response: HTTPURLResponse,
        data: Data?)
        -> ValidationResult
        where S.Iterator.Element == String
    {
        guard let data = data, data.count > 0 else { return .success }

        guard
            let responseContentType = response.mimeType,
            let responseMIMEType = MIMEType(responseContentType)
        else {
            for contentType in acceptableContentTypes {
                if let mimeType = MIMEType(contentType), mimeType.isWildcard {
                    return .success
                }
            }

<<<<<<< HEAD
            let contentType: String
            let failureReason: String

            if let responseContentType = response.MIMEType {
                contentType = responseContentType

                failureReason = (
                    "Response content type \"\(responseContentType)\" does not match any acceptable " +
                    "content types: \(acceptableContentTypes)"
                )
            } else {
                contentType = ""
                failureReason = "Response content type was missing and acceptable content type does not match \"*/*\""
            }

            let error = NSError(
                domain: Error.Domain,
                code: Error.Code.ContentTypeValidationFailed.rawValue,
                userInfo: [
                    NSLocalizedFailureReasonErrorKey: failureReason,
                    Error.UserInfoKeys.ContentType: contentType
                ]
            )

            return .Failure(error)
=======
            let error: AFError = {
                let reason: ErrorReason = .missingContentType(acceptableContentTypes: Array(acceptableContentTypes))
                return AFError.responseValidationFailed(reason: reason)
            }()

            return .failure(error)
        }

        for contentType in acceptableContentTypes {
            if let acceptableMIMEType = MIMEType(contentType), acceptableMIMEType.matches(responseMIMEType) {
                return .success
            }
>>>>>>> b18bd8c21aabb1c63e51708b735d2a09f40b6baf
        }

        let error: AFError = {
            let reason: ErrorReason = .unacceptableContentType(
                acceptableContentTypes: Array(acceptableContentTypes),
                responseContentType: responseContentType
            )

            return AFError.responseValidationFailed(reason: reason)
        }()

        return .failure(error)
    }
}

// MARK: -

extension DataRequest {
    /// A closure used to validate a request that takes a URL request, a URL response and data, and returns whether the
    /// request was valid.
    public typealias Validation = (URLRequest?, HTTPURLResponse, Data?) -> ValidationResult

    /// Validates the request, using the specified closure.
    ///
    /// If validation fails, subsequent calls to response handlers will have an associated error.
    ///
    /// - parameter validation: A closure to validate the request.
    ///
    /// - returns: The request.
    @discardableResult
    public func validate(_ validation: @escaping Validation) -> Self {
        let validationExecution: () -> Void = { [unowned self] in
            if
                let response = self.response,
                self.delegate.error == nil,
                case let .failure(error) = validation(self.request, response, self.delegate.data)
            {
                self.delegate.error = error
            }
        }

<<<<<<< HEAD
    /**
        Validates that the response has a status code in the default acceptable range of 200...299, and that the content
        type matches any specified in the Accept HTTP header field.
=======
        validations.append(validationExecution)
>>>>>>> b18bd8c21aabb1c63e51708b735d2a09f40b6baf

        return self
    }

    /// Validates that the response has a status code in the specified sequence.
    ///
    /// If validation fails, subsequent calls to response handlers will have an associated error.
    ///
    /// - parameter range: The range of acceptable status codes.
    ///
    /// - returns: The request.
    @discardableResult
    public func validate<S: Sequence>(statusCode acceptableStatusCodes: S) -> Self where S.Iterator.Element == Int {
        return validate { [unowned self] _, response, _ in
            return self.validate(statusCode: acceptableStatusCodes, response: response)
        }
    }

    /// Validates that the response has a content type in the specified sequence.
    ///
    /// If validation fails, subsequent calls to response handlers will have an associated error.
    ///
    /// - parameter contentType: The acceptable content types, which may specify wildcard types and/or subtypes.
    ///
    /// - returns: The request.
    @discardableResult
    public func validate<S: Sequence>(contentType acceptableContentTypes: S) -> Self where S.Iterator.Element == String {
        return validate { [unowned self] _, response, data in
            return self.validate(contentType: acceptableContentTypes, response: response, data: data)
        }
    }

    /// Validates that the response has a status code in the default acceptable range of 200...299, and that the content
    /// type matches any specified in the Accept HTTP header field.
    ///
    /// If validation fails, subsequent calls to response handlers will have an associated error.
    ///
    /// - returns: The request.
    @discardableResult
    public func validate() -> Self {
        return validate(statusCode: self.acceptableStatusCodes).validate(contentType: self.acceptableContentTypes)
    }
}

// MARK: -

extension DownloadRequest {
    /// A closure used to validate a request that takes a URL request, a URL response, a temporary URL and a
    /// destination URL, and returns whether the request was valid.
    public typealias Validation = (
        _ request: URLRequest?,
        _ response: HTTPURLResponse,
        _ temporaryURL: URL?,
        _ destinationURL: URL?)
        -> ValidationResult

    /// Validates the request, using the specified closure.
    ///
    /// If validation fails, subsequent calls to response handlers will have an associated error.
    ///
    /// - parameter validation: A closure to validate the request.
    ///
    /// - returns: The request.
    @discardableResult
    public func validate(_ validation: @escaping Validation) -> Self {
        let validationExecution: () -> Void = { [unowned self] in
            let request = self.request
            let temporaryURL = self.downloadDelegate.temporaryURL
            let destinationURL = self.downloadDelegate.destinationURL

            if
                let response = self.response,
                self.delegate.error == nil,
                case let .failure(error) = validation(request, response, temporaryURL, destinationURL)
            {
                self.delegate.error = error
            }
        }

        validations.append(validationExecution)

        return self
    }

    /// Validates that the response has a status code in the specified sequence.
    ///
    /// If validation fails, subsequent calls to response handlers will have an associated error.
    ///
    /// - parameter range: The range of acceptable status codes.
    ///
    /// - returns: The request.
    @discardableResult
    public func validate<S: Sequence>(statusCode acceptableStatusCodes: S) -> Self where S.Iterator.Element == Int {
        return validate { [unowned self] _, response, _, _ in
            return self.validate(statusCode: acceptableStatusCodes, response: response)
        }
    }

    /// Validates that the response has a content type in the specified sequence.
    ///
    /// If validation fails, subsequent calls to response handlers will have an associated error.
    ///
    /// - parameter contentType: The acceptable content types, which may specify wildcard types and/or subtypes.
    ///
    /// - returns: The request.
    @discardableResult
    public func validate<S: Sequence>(contentType acceptableContentTypes: S) -> Self where S.Iterator.Element == String {
        return validate { [unowned self] _, response, _, _ in
            let fileURL = self.downloadDelegate.fileURL

            guard let validFileURL = fileURL else {
                return .failure(AFError.responseValidationFailed(reason: .dataFileNil))
            }

            do {
                let data = try Data(contentsOf: validFileURL)
                return self.validate(contentType: acceptableContentTypes, response: response, data: data)
            } catch {
                return .failure(AFError.responseValidationFailed(reason: .dataFileReadFailed(at: validFileURL)))
            }
        }
    }

    /// Validates that the response has a status code in the default acceptable range of 200...299, and that the content
    /// type matches any specified in the Accept HTTP header field.
    ///
    /// If validation fails, subsequent calls to response handlers will have an associated error.
    ///
    /// - returns: The request.
    @discardableResult
    public func validate() -> Self {
        return validate(statusCode: self.acceptableStatusCodes).validate(contentType: self.acceptableContentTypes)
    }
}
