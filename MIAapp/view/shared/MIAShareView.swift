//
//  MIAShareView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 01.06.22.
//

import SwiftUI

struct MIAShareView: View {
    
    let url: URL
    
    var body: some View {
        Button(action: showShareView) {
            Image(systemName: "square.and.arrow.up")
        }
    }
    
    func showShareView() {
        let sharedText = "Sent with ❤️ from your MIA App."
        let sharedItems = [url, sharedText] as [Any]
        let ac = UIActivityViewController(activityItems: sharedItems, applicationActivities: nil)
        
        let allScenes = UIApplication.shared.connectedScenes
        let scene = allScenes.first { $0.activationState == .foregroundActive }
        if let windowScene = scene as? UIWindowScene {
            windowScene.keyWindow?.rootViewController?.present(ac, animated: true, completion: nil)
        }
    }
}

