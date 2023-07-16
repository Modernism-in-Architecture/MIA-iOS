//
//  MIAToolBarLogo.swift
//  MIAapp
//
//  Created by Sören Kirchner on 01.03.22.
//

import SwiftUI

struct MIAToolBarLogo: View {
    var body: some View {
        Image("mia")
            .resizable()
            .scaledToFit()
            .frame(width: 36)
    }
}

struct MIAToolBarLogo_Previews: PreviewProvider {
    static var previews: some View {
        MIAToolBarLogo()
    }
}
