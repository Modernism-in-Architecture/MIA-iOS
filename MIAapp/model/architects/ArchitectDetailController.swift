//
//  ArchitectDetailController.swift
//  MIAapp
//
//  Created by Sören Kirchner on 08.02.22.
//

import Foundation

class ArchitectDetailController: ObservableObject {
    
    @Published var architectDetail: LoadingStateWithContent<ArchitectDetail.Details> = .loading
    
    func fetchData(for id: Int) async {
        let result = await MIAClient.fetchData(for: API.request(for: API.architect(for: id)), of: ArchitectDetail.self)
        DispatchQueue.main.async {
            switch result {
            case .success(let data):
                self.architectDetail = .success(data.data)
            case .failure(let error):
                // TODO: pass real error if changed to ManagerError

                self.architectDetail = .error(.notImplementedError)
            }
        }
//        do {
//            let (data, response) = try await URLSession.shared.data(for: API.request(for: API.architect(for: id)))
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                architectDetail = .error(.NetworkError)
//                return
//            }
//            let result = try JSONDecoder().decode(ArchitectDetail.self, from: data)
//            DispatchQueue.main.async {
//                self.architectDetail = .success(result.data)
//            }
//        } catch {
//            self.architectDetail = .error(.UnknownError)
//        }
    }
}
