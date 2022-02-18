//
//  BuildingDetailController.swift
//  MIAapp
//
//  Created by Sören Kirchner on 23.10.21.
//

import Foundation

class BuildingDetailController: ObservableObject {
    
    @Published var detail: LoadingStateWithContent<BuildingDetail.Detail> = .loading
    
    func fetchData(for id: Int) async {
        let result = await MIAClient.fetchData(for: API.request(for: API.building(for: id)), of: BuildingDetail.self)
        DispatchQueue.main.async {
            switch result {
            case .success(let data):
                self.detail = .success(data.data)
            case .failure(let error):
                self.detail = .error(error)
            }
        }
    }
//        print(id)
////        var request = URLRequest(url: url, timeoutInterval: API.timeoout)
////        request.addValue("Token \(Secret.token)", forHTTPHeaderField: "Authorization")
//        do {
//            let (data, _) = try await URLSession.shared.data(for: API.request(for: API.building(for: id)))
//            let result = try JSONDecoder().decode(BuildingDetail.self, from: data)
//            DispatchQueue.main.async {
//                self.detail = .success(result.data)
//            }
//        } catch {
//            print(error)
//        }
//    }
    
}
