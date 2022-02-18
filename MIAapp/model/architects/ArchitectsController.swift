//
//  ArchitectsController.swift
//  MIAapp
//
//  Created by Sören Kirchner on 06.02.22.
//

import Foundation

class ArchitectsController: ObservableObject {
    
    @Published var architects: [Architect] = []
    @Published var state: LoadingState = .loading
  
    func fetchData() async {
        let result = await MIAClient.fetchData(for: API.request(for: API.architects), of: Architects.self)
        DispatchQueue.main.async {
            switch result {
            case .success(let data):
                self.architects = data.data
                self.state = .success
            case .failure(let error):
                self.state = .error(error)
            }
        }
    }
    
//    func fetchData() async {
//        do {
//            let (data, response) = try await URLSession.shared.data(for: API.request(for: API.architects))
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                state = .error(.NetworkError)
//                return
//            }
//            let result = try JSONDecoder().decode(Architects.self, from: data)
//            DispatchQueue.main.async {
//                self.architects = result.data
//                self.state = .success
//            }
//        } catch {
//            state = .error(.UnknownError)
//        }
//    }
}
