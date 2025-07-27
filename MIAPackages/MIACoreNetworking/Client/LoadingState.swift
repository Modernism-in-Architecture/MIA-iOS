//
//  LoadingState.swift
//  MIAapp
//
//  Created by Sören Kirchner on 08.02.22.
//

import Foundation

public enum LoadingState<Value> {

    case loading
    case success(Value)
    case error(ManagerError)
}
