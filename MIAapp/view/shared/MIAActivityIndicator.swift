//
//  MIAActivityIndicator.swift
//  MIAapp
//
//  Created by Sören Kirchner on 14.02.22.
//

import SwiftUI

struct MIAActivityIndicator: View {
    @State private var endPoint = 0.0

    var body: some View {
        return ZStack {
            Ring(endPoint: endPoint)
                .stroke(Color.green, lineWidth: 4)
                .rotationEffect(Angle(degrees: 90))
                .task {
                    withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: false)) {
                        self.endPoint = 0.99
                    }
                }
            Image("mia")
                .resizable()
                .scaledToFit()
                .frame(width: 50)
        }
        .frame(width: 100, height: 100)
    }
}

struct Ring: Shape {
    var endPoint: Double
    var delayPoint = 0.5

    var animatableData: Double {
        get { return endPoint }
        set { endPoint = newValue }
    }

    func path(in rect: CGRect) -> Path {
        return Path { path in
            let startPoint = (endPoint > delayPoint) ? (2 * endPoint) : 0
            path.addArc(center: CGPoint(x: rect.size.width/2, y: rect.size.width/2),
                        radius: rect.size.width/2,
                        startAngle: .normal(startPoint),
                        endAngle: .normal(endPoint),
                        clockwise: false)
        }
    }
}

extension Angle {
    static func normal(_ value: Double) -> Angle {
        return .degrees(value * 360)
    }
}

struct MIAActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        MIAActivityIndicator()
            .scaleEffect(1)
    }
}
