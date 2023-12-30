//
//  MIAClient.swift
//  MIAapp
//
//  Created by Sören Kirchner on 14.02.22.
//

import SwiftUI

// MARK: - MIAClient

class MIAClient {

    private static let session = URLSession.shared

    static func fetch(_ request: URLRequest) async -> Result<ClientResult, ClientError> {
        
        do {
            
            let (data, response) = try await session.data(for: request, delegate: nil)
            
            guard let response = response as? HTTPURLResponse else {
                return .failure(.InternalError(GenericError(message: "not a HTTPURLResponse")))
            }
            
            switch response.statusCode {
            case 200..<300:
                return .success(ClientResult(data: data, respone: response))
                
            case 400..<500:
                return .failure(.HTTPClientError(response))
                
            case 500..<600:
                return .failure(.HTTPServerError(response))
                
            default:
                return .failure(.InternalError(GenericError(message: "Unexpected HTTP status code: \(response.statusCode)")))
            }
        } catch {
            return .failure(.InternalError(GenericError(message: error.localizedDescription)))
        }
    }
}

// MARK: - MIAClient + Image Download

extension MIAClient {

    static func downloadImage(from url: URL?) async -> Result<UIImage, ClientError> {
        
        guard let url else {
            return .failure(.InternalError(.init(message: "Image Url corrupted")))
        }
        
        if let image = ImageCacheManager.instance.get(url: url) {
            return .success(image)
        }
        
        let result = await fetch(URLRequest(url: url))
        
        switch result {
            
        case .success(let clientResult):
            
            guard let newImage = UIImage(data: clientResult.data) else {
                return .failure(.InternalError(GenericError(message: "Image data corrupted")))
            }
            let expirationDate = MIAClient.getExpireDate(response: clientResult.respone)
            ImageCacheManager.instance.add(image: newImage, for: url, until: expirationDate)
            return .success(newImage)
            
        case .failure(let error):
            return .failure(error)
        }
    }

    static func getExpireDate(response: HTTPURLResponse) -> Date {
        
        let defaultDate = Date(timeIntervalSinceNow: MIADefaults.ImageCache.maxAge)
        guard
            let cacheControl = response.value(forHTTPHeaderField: "Cache-Control"),
            let maxAgeValue = cacheControl.components(separatedBy: ",")
            .filter({ $0.contains("max-age") }).first?
            .components(separatedBy: "=").last?
            .trimmingCharacters(in: .whitespaces),
            let maxAge = TimeInterval(maxAgeValue)
        else {
            return defaultDate
        }

        return min(Date(timeIntervalSinceNow: maxAge), defaultDate)
    }
}

// MARK: - ClientResult

struct ClientResult {
    
    let data: Data
    let respone: HTTPURLResponse
}

// MARK: - ClientError

enum ClientError: Error {
    
    case HTTPClientError(HTTPURLResponse)
    case HTTPServerError(HTTPURLResponse)
    case DecodingError(DecodingError)
    case InternalError(GenericError)
}

// MARK: - GenericError

struct GenericError: Error {
    let message: String
}
