//
//  LoadingState.swift
//  MIAapp
//
//  Created by Sören Kirchner on 08.02.22.
//

import Foundation

enum LoadingStateWithContent<Value> {
//    case idle
    case loading
    case success(Value)
    case error(ManagerError)
}

enum LoadingState {
    case loading
    case success
    case error(MiaClientError)
}
