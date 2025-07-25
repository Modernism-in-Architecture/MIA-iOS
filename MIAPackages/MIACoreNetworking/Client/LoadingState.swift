//
//  LoadingState.swift
//  MIAapp
//
//  Created by Sören Kirchner on 08.02.22.
//

import Foundation

public enum LoadingStateWithContent<Value> {

    case loading
    case success(Value)
    case error(ManagerError)
}

public enum LoadingState {

    case loading
    case success
    case error(ManagerError)
}
