import Foundation
import Alamofire

public protocol NetworkManagerProtocol: Sendable {
    func request<T: Decodable & Sendable>(
        endpoint: Endpoint,
        responseType: T.Type
    ) async throws -> T
}

public actor NetworkManager: NetworkManagerProtocol {
    
    public static let shared = NetworkManager()
    
    private let session: Session
    private let decoder: JSONDecoder
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        self.session = Session(configuration: configuration)
        
        self.decoder = JSONDecoder()
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.decoder.dateDecodingStrategy = .iso8601
    }
    
    public func request<T: Decodable & Sendable>(
        endpoint: Endpoint,
        responseType: T.Type
    ) async throws -> T {
        
        #if DEBUG
        print("Request: \(endpoint.method.rawValue) \(endpoint.url)")
        if let params = endpoint.parameters {
            print("Parameters: \(params)")
        }
        if let headers = endpoint.headers {
            print("Headers: \(headers)")
        }
        #endif
        
        let dataRequest = session.request(
            endpoint.url,
            method: endpoint.method,
            parameters: endpoint.parameters,
            encoding: endpoint.encoding,
            headers: endpoint.headers
        )
        .validate()
        
        do {
            // Use serializingDecodable to get the response
            let response = try await dataRequest
                .serializingDecodable(T.self, decoder: decoder)
                .value
            
            #if DEBUG
            print("Success: \(endpoint.url)")
            #endif
            
            return response
            
        } catch {
            #if DEBUG
            print("Error: \(endpoint.url) - \(error.localizedDescription)")
            #endif
            
            // Try to get response data for error parsing
            if let afError = error as? AFError {
                throw await handleAFError(afError, from: dataRequest)
            }
            
            throw NetworkError.networkFailure(error.localizedDescription)
        }
    }
    
    private func handleAFError(_ error: AFError, from request: DataRequest) async -> NetworkError {
        
        // Check for network connectivity
        if let urlError = error.underlyingError as? URLError {
            switch urlError.code {
            case .notConnectedToInternet, .networkConnectionLost:
                return .noInternetConnection
            case .timedOut:
                return .timeout
            default:
                return .networkFailure(urlError.localizedDescription)
            }
        }
        
        // Try to get response data
        var responseData: Data?
        var statusCode: Int?
        
        do {
            let data = try await request.serializingData().value
            responseData = data
        } catch {
            // Could not get data
        }
        
        // Get status code from error
        if case .responseValidationFailed(let reason) = error {
            switch reason {
            case .unacceptableStatusCode(let code):
                statusCode = code
            default:
                break
            }
        }
        
        // Try to parse Dsquares API error response
        if let data = responseData {
            #if DEBUG
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Error Response: \(jsonString)")
            }
            #endif
            
            if let apiError = try? decoder.decode(DsquaresErrorResponse.self, from: data) {
                return .apiError(
                    statusCode: apiError.statusCode,
                    statusName: apiError.statusName,
                    message: apiError.message
                )
            }
        }
        
        // Check HTTP status codes
        if let statusCode = statusCode {
            switch statusCode {
            case 401:
                return .unauthorized
            case 400...499:
                let message = parseErrorMessage(from: responseData)
                return .serverError(statusCode: statusCode, message: message)
            case 500...599:
                let message = parseErrorMessage(from: responseData)
                return .serverError(statusCode: statusCode, message: message)
            default:
                break
            }
        }
        
        // Check for decoding errors
        if error.isResponseSerializationError {
            return .decodingError(error.localizedDescription)
        }
        
        return .networkFailure(error.localizedDescription)
    }
    
    private func parseErrorMessage(from data: Data?) -> String? {
        guard let data = data,
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let message = json["message"] as? String else {
            return nil
        }
        return message
    }
}

// MARK: - Error Response Model
private struct DsquaresErrorResponse: Decodable, Sendable {
    let statusName: String
    let message: String?
    let referenceCode: String?
    let statusCode: Int
}
