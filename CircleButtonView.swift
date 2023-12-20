//
//  CircleButtonView.swift
//  GlassmorphismPractice
//
//  Created by Riley Calkins on 12/19/23.
//

import SwiftUI

struct CircleButtonView: View {
    var gradient: Gradient
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 40, height: 40)
                .foregroundStyle(gradient.opacity(0.4))
            Circle()
                .frame(width: 33, height: 33)
                .foregroundStyle(
                    gradient.opacity(0.8)
                )
                .overlay{
                    Circle().stroke(.white, lineWidth: 0.3)
                }
        }
    }
}

struct RowButtonStyle: ButtonStyle {
    @State var gradient: IdGradient
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            
    }
}
