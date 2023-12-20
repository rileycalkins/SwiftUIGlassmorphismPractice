//
//  ContentView.swift
//  GlassmorphismPractice
//
//  Created by Riley Calkins on 12/18/23.
//

import SwiftUI



struct IdGradient: Identifiable, Hashable {
    let id: UUID
    let gradient: Gradient
    let name: String
    init(_ gr: Gradient, name: String) {
        self.id = UUID()
        self.gradient = gr
        self.name = name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self)
    }
}



struct MyGradients {
    var shared: [IdGradient] = []
    
    init() {
        shared = [
            IdGradient(.gradient1, name: "Gradient 1"), IdGradient(.gradient2, name: "Gradient 2"), IdGradient(.gradient3, name: "Gradient 3"), IdGradient(.gradient4, name: "Gradient 4"), IdGradient(.gradient5, name: "Gradient 5"), IdGradient(.gradient6, name:"Gradient 6"), IdGradient(.gradient7, name:"Gradient 7"), IdGradient(.gradient8, name:"Gradient 8"), IdGradient(.gradient9, name:"Gradient 9"), IdGradient(.gradient10, name:"Gradient 10"),
            IdGradient(.gradient11, name:"Gradient 11"), IdGradient(.gradient12, name:"Gradient 12"), IdGradient(.gradient13, name:"Gradient 13"), IdGradient(.gradient14, name:"Gradient 14"), IdGradient(.gradient15, name:"Gradient 15"), IdGradient(.gradient16, name:"Gradient 16"), IdGradient(.gradient17, name:"Gradient 17"), IdGradient(.gradient18, name:"Gradient 18"), IdGradient(.gradient19, name:"Gradient 19"), IdGradient(.gradient20, name:"Gradient 20"),
            IdGradient(.gradient21, name:"Gradient 21"), IdGradient(.gradient22, name:"Gradient 22"), IdGradient(.gradient23, name:"Gradient 23"), IdGradient(.gradient24, name:"Gradient 24"), IdGradient(.gradient25, name:"Gradient 25"), IdGradient(.gradient26, name:"Gradient 26"), IdGradient(.gradient27, name:"Gradient 27"), IdGradient(.gradient28, name:"Gradient 28"), IdGradient(.gradient29, name:"Gradient 29"), IdGradient(.gradient30, name:"Gradient 30"),
            IdGradient(.gradient31, name:"Gradient 31"), IdGradient(.gradient32, name:"Gradient 32"), IdGradient(.gradient33, name:"Gradient 33"), IdGradient(.gradient34, name:"Gradient 34"), IdGradient(.gradient35, name:"Gradient 35"), IdGradient(.gradient36, name:"Gradient 36"), IdGradient(.gradient37, name:"Gradient 37"), IdGradient(.gradient38, name:"Gradient 38"), IdGradient(.gradient39, name:"Gradient 39"), IdGradient(.gradient40, name:"Gradient 40"),
            IdGradient(.gradient41, name:"Gradient 41"), IdGradient(.gradient42, name:"Gradient 42"), IdGradient(.gradient43, name:"Gradient 43"), IdGradient(.gradient44, name:"Gradient 44"), IdGradient(.gradient45, name:"Gradient 45"), IdGradient(.gradient46, name:"Gradient 46"), IdGradient(.gradient47, name:"Gradient 47"), IdGradient(.gradient48, name:"Gradient 48")
        ]
    }
}

class ColorManager: ObservableObject {
    @Published var selectedGradient: IdGradient
    @Published var gradients = MyGradients().shared
    
    init() {
        self.selectedGradient = IdGradient(.gradient1, name: "Gradient 1")
        
    }
    
    func selectGradient() {
        
    }
}

enum GradientType: Hashable, Equatable {
    
    case angular
    case elliptical
    case linear
    case radial
    
    var textDescription: String {
        switch self {
        case .angular:
            return "Angular Gradient"
        case .elliptical:
            return "Elliptical Gradient"
        case .linear:
            return "Linear Gradient"
        case .radial:
            return "Radial Gradient"
        }
    }
    
    var selectedType: Int {
        switch self {
        case .angular:
            return 1
        case .elliptical:
            return 2
        case .linear:
            return 3
        case .radial:
            return 4
        }
    }
    
    func returnTextDescription() -> String {
        return textDescription
    }
    
    static func == (lhs: GradientType, rhs: GradientType) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self)
    }
}

struct ColorSet {
    let color1: Color
    let color2: Color
}

struct ContentView: View {
    @StateObject var colorManager: ColorManager = ColorManager()
    //    @State var selectedGradient: Gradient = .gradient1
    var body: some View {
        TabView {
            GradientView(type: .angular, colorManager: colorManager)
                .tabItem {
                    TabItemView(img: "angle", text: "Angular").tag(1)
                }
            
            GradientView(type: .elliptical, colorManager: colorManager)
                .tabItem {
                    TabItemView(img: "moonphase.new.moon.inverse", text: "Elliptical").tag(2)
                }
            
            GradientView(type: .linear, colorManager: colorManager)
            
                .tabItem {
                    TabItemView(img: "align.horizontal.center", text: "Linear").tag(3)
                }
            GradientView(type: .radial, colorManager: colorManager)
                .tabItem {
                    TabItemView(img: "moonphase.new.moon.inverse", text: "Radial").tag(4)
                }
            
        }.tint(.white)
            .background(Color.clear)
//            .introspect(.tabView, on: .iOS(.v17)) { iOS in
//                iOS.tabBar.standardAppearance.configureWithTransparentBackground()
//            }
    }
}







#Preview {
    ContentView()
}


