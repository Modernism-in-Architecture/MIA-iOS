//
//  MIAClient.swift
//  MIAapp
//
//  Created by Sören Kirchner on 14.02.22.
//

import Foundation
import SwiftUI

class MIAClient {
    
    private static let session = URLSession.shared
    
    private static func fetch(request: URLRequest) async -> Result<ClientResult, ClientError> {
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
    
    // TODO: Replace by mothod above
    public static func fetchData<Value>(for request: URLRequest, of type: Value.Type) async -> (Result<Value, MiaClientError>) where Value: Decodable {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return .failure(.NetworkError)
            }
            let result = try JSONDecoder().decode(type, from: data)
            return .success(result)
        } catch {
            print(error)
            return .failure(.UnknownError)
        }
    }
    
    static func downloadImage(from url: URL) async -> Result<UIImage, ClientError> {
        if let image = ImageCacheManager.instance.get(url: url) { return .success(image) }
        let result = await fetch(request: URLRequest(url: url))
        switch result {
        case .success(let clientResult):
            guard let newImage = UIImage(data: clientResult.data) else { return .failure(.InternalError(GenericError(message: "Image data corrupted"))) }
            let expirationDate = MIAClient.getExpireDate(response: clientResult.respone)
            ImageCacheManager.instance.add(image: newImage, for: url, until: expirationDate)
            return .success(newImage)
        case .failure(let error):
            return .failure(error)
        }
    }

    public static func getExpireDate(response: HTTPURLResponse) -> Date {
        let defaultDate = Date(timeIntervalSinceNow: MIADefaults.ImageCache.maxAge)
        guard
            let cacheControl = response.value(forHTTPHeaderField: "Cache-Control"),
            let maxAgeValue = cacheControl.components(separatedBy: ",")
            .filter({ $0.contains("max-age") }).first?
            .components(separatedBy: "=").last?
            .trimmingCharacters(in: .whitespaces),
            let maxAge = TimeInterval(maxAgeValue)
        else { return defaultDate }

        return min(Date(timeIntervalSinceNow: maxAge), defaultDate)
    }
}

struct ClientResult {
    let data: Data
    let respone: HTTPURLResponse
}

enum ClientError: Error {
    case HTTPClientError(HTTPURLResponse)
    case HTTPServerError(HTTPURLResponse)
    case DecodingError(DecodingError)
    case InternalError(GenericError)
}

struct GenericError: Error {
    let message: String
}
