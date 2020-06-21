//
//  URLSessionManager.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/19/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

protocol NetworkProtocol: class {
    func call<T: Codable>(_ endpoint: Endpoint, _ expectedModel: T.Type, onComplete: @escaping ((Result<T, Error>) -> Void))
    func cancelPreviousTask()
}

final class URLSessionManager: NetworkProtocol {
    lazy private var session = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    
    /// Calls the selected Endpoint after building the URL Request through the URLRequestFactory
    /// - Parameters:
    ///   - endpoint: desired Endpoint to hit
    ///   - expectedModel: the model that the business layer expects
    ///   - onComplete: completion handler
    func call<T: Codable>(_ endpoint: Endpoint, _ expectedModel: T.Type, onComplete: @escaping ((Result<T, Error>) -> Void)) {
        let urlRequest = URLRequestFactory.generateRequest(outOf: endpoint)
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            self.dataTask = self.session.dataTask(with: urlRequest) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = error, !error.shouldIgnore() {
                        onComplete(.failure(error))
                    } else if let data = data, let response = response as? HTTPURLResponse {
                        switch response.statusCode {
                        case 200...399:
                            guard let parsedModel = data.decode(expectedModel) else {
                                onComplete(.failure(NetworkError.somethingWentWrong))
                                return
                            }
                            onComplete(.success(parsedModel))
                        default:
                            onComplete(.failure(NetworkError.somethingWentWrong))
                        }
                    }
                }
            }
            
            self.dataTask?.resume()
        }
    }
    
    func cancelPreviousTask() {
        dataTask?.cancel()
    }
}

final class URLRequestFactory {
    /// Generates URL out of endpoint protocol
    /// - Parameter endpoint: the protocol that carries the details of the request
    /// - Returns: the URL to be used to build the URLRequest
    private static func generateURL(outOf endpoint: Endpoint) -> URL {
        guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
            // We used a fatalError here with a helpful message so that if we had a
            // typo in the path or the baseURL, this fatalError notifies us, Normally
            // i'd go for an assertionFailure so it doesn't crash the app in
            // production, but since am sure this won't happen in production but only
            // in development, so I don't see anything wrong with it
            fatalError("You probably passed a wrong URL,\n check \(endpoint.baseURL) or \(endpoint.path)")
        }
        return url
    }
    
    /// Encodes the parameters in the URL
    private static func encodeParametersInURL(in urlRequest: inout URLRequest, endpoint: Endpoint) {
        guard let url = urlRequest.url?.absoluteString else { return }
        guard var urlComponents = URLComponents(string: url) else { return }
        urlComponents.queryItems = endpoint.parameters.map { key, value in
            URLQueryItem(name: key, value: value as? String ?? "")
        }
        
        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        urlRequest.url = urlComponents.url
    }
    
    /// Encodes the parameters in the Request Body
    private static func encodeParametersInBodyOfRequest(in request: inout URLRequest, endpoint: Endpoint) {
        do {
            let data = try JSONSerialization.data(withJSONObject: endpoint.parameters, options: [])
            request.httpBody = data
        } catch {
            // TODO: - Replace print with a logger
            print(error)
        }
        
    }
    
    /// Handles How the parameters will be encoded according to the endpoint encoding
    private static func encodeRequestWithParameters(_ request: inout URLRequest, from endpoint: Endpoint) {
        switch endpoint.encoding {
        case .urlEncoding:
            encodeParametersInURL(in: &request, endpoint: endpoint)
        case .jsonEncoding:
            encodeParametersInBodyOfRequest(in: &request, endpoint: endpoint)
        }
    }
    
    /// Generates URLRequest after building the URL, injecting the method and the headers
    /// and encoding the Parameters suitably according to the endpoint
    /// - Parameter endpoint: the protocol that carries the details of the request
    /// - Returns: URLRequest for the manager to use
    static func generateRequest(outOf endpoint: Endpoint) -> URLRequest {
        let url = generateURL(outOf: endpoint)
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = endpoint.method.rawValue
        
        endpoint.headers.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        encodeRequestWithParameters(&urlRequest, from: endpoint)
        
        return urlRequest
    }
}
