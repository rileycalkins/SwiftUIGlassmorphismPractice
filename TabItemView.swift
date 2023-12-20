//
//  TabItemView.swift
//  GlassmorphismPractice
//
//  Created by Riley Calkins on 12/19/23.
//

import SwiftUI

struct TabItemView: View {
    let img: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: img)
            Text(text)
        }.tint(.white)
    }
}
