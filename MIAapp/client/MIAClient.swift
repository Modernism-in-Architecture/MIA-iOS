//
//  MIAClient.swift
//  MIAapp
//
//  Created by Sören Kirchner on 14.02.22.
//

import Foundation

class MIAClient {
    
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
    
}
