//
//  MIADataController.swift
//  MIAapp
//
//  Created by Sören Kirchner on 17.10.21.
//

import Foundation

class BuildingsController: ObservableObject {
    
    @Published var buildings: [Building] = []
    @Published var state: LoadingState = .loading
    
    func fetchData() async {
        let result = await MIAClient.fetchData(for: API.request(for: API.buildings), of: Buildings.self)
        DispatchQueue.main.async {
            switch result {
            case .success(let data):
                self.buildings = data.data
                self.state = .success
            case .failure(let error):
                self.state = .error(error)
            }
        }
    }
//        var request = URLRequest(url: API.buildings, timeoutInterval: API.timeoout)
//        request.addValue("Token \(Secret.token)", forHTTPHeaderField: "Authorization")
//        do {
//            let (data, response) = try await URLSession.shared.data(for: API.request(for: API.buildings))
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                state = .error(.NetworkError)
//                return
//            }
//            let result = try JSONDecoder().decode(Buildings.self, from: data)
//            DispatchQueue.main.async {
//                self.buildings.append(contentsOf: result.data)
//                self.state = .success
//            }
//        } catch {
//            state = .error(.UnknownError)
//        }
//    }
}
