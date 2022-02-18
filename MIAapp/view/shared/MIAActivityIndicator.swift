//
//  MIAActivityIndicator.swift
//  MIAapp
//
//  Created by Sören Kirchner on 14.02.22.
//

import SwiftUI

//struct MIAActivityIndicator: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//struct MIAActivityIndicator_Previews: PreviewProvider {
//    static var previews: some View {
//        MIAActivityIndicator()
//    }
//}

struct MIAActivityIndicator: View {
    
    @State private var fillPoint = 0.0
    
    private var animation: Animation {
        Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: false)
    }
    
    var body: some View {
        let _ = Self._printChanges()
        ZStack {
            Ring (endPoint: fillPoint)
                .stroke(Color.green, lineWidth: 4)
//                .frame(width: 100, height: 100)
                .onAppear() {
                    withAnimation(self.animation) {
                        self.fillPoint = 1.0
                    }
            }
            .rotationEffect(Angle(degrees: 90))
            Image("mia")
                .resizable()
                .scaledToFit()
                .frame(width: 50)
        }
        .frame(width: 100, height: 100)
//        .transition(.opacity.animation(.easeInOut(duration: 0.5)))
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
//        let startPoint = (endPoint > delayPoint) ? (2 * endPoint) : 0
//        var path = Path()
//
//        path.addArc(center: CGPoint(x: rect.size.width/2, y: rect.size.width/2),
//                    radius: rect.size.width/2,
//                    startAngle: .normal(startPoint),
//                    endAngle: .normal(endPoint),
//                    clockwise: false)
//        return path
        
        return Path { path in
            let startPoint = (endPoint > delayPoint) ? (2 * endPoint) : 0

//            let startPoint = 0.0
//            let endPoint = 0.5
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
            .scaleEffect(0.5)
    }
}
