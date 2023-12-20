//
//  GlassWindowView.swift
//  GlassmorphismPractice
//
//  Created by Riley Calkins on 12/19/23.
//

import SwiftUI

struct UltraThinGlassWindowView<Content: View>: View {
    
    var cornerRadius: CGFloat
    var alignment: Alignment
    let content: () -> Content
    
    init(cornerRadius: CGFloat = 25, alignment: Alignment = .center, @ViewBuilder content: @escaping () -> Content) {
        self.cornerRadius = cornerRadius
        self.content = content
        self.alignment = alignment
    }
    
    var body: some View {
        
        ZStack(alignment: alignment) {
            background
            content()
        }
    }
    
    var background: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundStyle(.ultraThinMaterial)
                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 10)
                .blur(radius: 1)
        }
    }
}

struct ThinGlassWindowView<Content: View>: View {
    var cornerRadius: CGFloat
    var alignment: Alignment
    let content: () -> Content
    
    init(cornerRadius: CGFloat = 25, alignment: Alignment = .top, @ViewBuilder content: @escaping () -> Content) {
        self.cornerRadius = cornerRadius
        self.content = content
        self.alignment = alignment
    }
    
    var body: some View {
        
        ZStack(alignment: alignment) {
            background
            content().padding()
        }
    }
    
    var background: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundStyle(.thinMaterial)
                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 10)
                .blur(radius: 1)
        }
    }
}
