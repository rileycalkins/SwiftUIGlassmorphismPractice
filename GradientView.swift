//
//  GradientView.swift
//  GlassmorphismPractice
//
//  Created by Riley Calkins on 12/19/23.
//

import SwiftUI

struct GradientView: View {
    //    let myGradients = MyGradients()
    @State var type: GradientType
    @StateObject var colorManager: ColorManager
    @State var selectedText: String = ""
    @State var startPoint: UnitPoint = .bottomLeading
    @State var centerPoint: UnitPoint = .center
    @State var endPoint: UnitPoint = .topTrailing
    @State var startAngle: Angle = .degrees(0)
    @State var endAngle: Angle = .degrees(180)
    @State var startRadFrac: CGFloat = 0.0
    @State var endRadFrac: CGFloat = 1.0
    @State var translation: CGSize = .zero
    @State private var offsetY: CGFloat = 0
    @State var showList: Bool = false
    @State var rowSelected: Bool = false
    @State var selectedGradientRow: IdGradient?
    @State var listHeight: CGFloat = 0
    @State var glassHeight: CGFloat = 120
    @State var sheetViewType: BottomSheetDisplayType = .none
    @State var topSheetViewType: TopSheetDisplayType = .none
    @State var currentTopDrawerHeight: CGFloat = 140
    @State var showBottomDrawer: Bool = false
    @State var showTopDrawer: Bool = false
    
    @State var angularCenterPointX: CGFloat = 0.5
    @State var angularCenterPointY: CGFloat = 0.5
    @State var angularStartAngle: Double = 0
    @State var angularEndAngle: Double = 360
    
    @State var ellipticalCenterPointX: CGFloat = 0.5
    @State var ellipticalCenterPointY: CGFloat = 0.5
    @State var startRadiusFraction: CGFloat = 0
    @State var endRadiusFraction: CGFloat = 1
    
    @State var linearStartPointX: CGFloat = 1
    @State var linearStartPointY: CGFloat = 0
    @State var linearEndPointX: CGFloat = 0
    @State var linearEndPointY: CGFloat = 1
    
    @State var radialCenterXPoint: CGFloat = 0.5
    @State var radialCenterYPoint: CGFloat = 0.5
    @State var radialStartRadius: CGFloat = 180
    @State var radialEndRadius: CGFloat = 0
    
    var angularView: some View {
        ZStack {
            AngularGradient(gradient: colorManager.selectedGradient.gradient, center: UnitPoint(x: angularCenterPointX, y: angularCenterPointY),
                            startAngle: Angle(degrees: angularStartAngle), endAngle: Angle(degrees: angularEndAngle))
        }
    }
    
    var ellipticalView: some View {
        ZStack {
            EllipticalGradient(gradient: colorManager.selectedGradient.gradient, center: UnitPoint(x: ellipticalCenterPointX, y: ellipticalCenterPointY), startRadiusFraction: startRadiusFraction, endRadiusFraction: endRadiusFraction)
        }
    }
    
    var linearView: some View {
        ZStack {
            LinearGradient(gradient: colorManager.selectedGradient.gradient, startPoint: UnitPoint(x: linearStartPointX, y: linearStartPointY), endPoint: UnitPoint(x: linearEndPointX, y: linearEndPointY))
        }
    }
    
    var radialView: some View {
        ZStack {
            
            RadialGradient(gradient: colorManager.selectedGradient.gradient, center: UnitPoint(x: radialCenterXPoint, y: radialCenterYPoint), startRadius: radialStartRadius, endRadius: radialEndRadius)
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            background
            content
            TopSheetAdvanceView(gr: $colorManager.selectedGradient, show: $showTopDrawer, showList: $showList, showBottomSheet: $showBottomDrawer, currentHeight: $currentTopDrawerHeight, displayType: $topSheetViewType, maxHeight: UIScreen.screenHeight) {
                VStack(spacing: 0) {
                    Spacer().frame(height: 20)
                    topGlass.opacity(showList ? 1 : 0)
                    Spacer().frame(height: 20)
                }
                
            }
            BottomSheetAdvanceView(gr: $colorManager.selectedGradient, show: $showBottomDrawer, showTopSheet: $showTopDrawer ,displayType: $sheetViewType, maxHeight: UIScreen.screenHeight) {
                VStack(alignment: .leading) {
                    if showBottomDrawer {
                        //                        Spacer().frame(height: 20)
                        switch type {
                        case .angular:
                            angularSettingsView
                        case .elliptical:
                            ellipticalSettingsView
                        case .linear:
                            linearSettingsView
                        case .radial:
                            radialSettingsView
                        
                        }
                        
                        HStack {
                            Text(colorManager.selectedGradient.name)
                                .foregroundStyle(.white)
                            Spacer()
                            CircleButtonView(gradient: colorManager.selectedGradient.gradient)
                        }
                        Spacer().frame(height: 20)
                        Button {
                        } label: {
                            ZStack(alignment: .center) {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(colorManager.selectedGradient.gradient)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(.white, lineWidth: 0.5)
                                        
                                        
                                    }
                                Text("Save Changes")
                                    .font(.title)
                                    .fontWeight(.light)
                            }.frame(height: 60)
                        }
                    }
                }
            }
            
            
            
        }.ignoresSafeArea(edges: .top)
            .safeAreaInset(edge: .top) {
                headerAndButton
                    .padding(.horizontal)
            }
        
        
    }
    
    var angularSettingsView: some View {
        VStack {
            Text("Angular Gradient Settings").font(.largeTitle)
                .foregroundStyle(.white)
                .padding(.vertical)
            HStack {
                Text("Center Point").font(.callout)
                    .foregroundStyle(.white)
                Spacer()
                Text("X:").foregroundStyle(.white)
                
                Slider(value: $angularCenterPointX, in: 0...1)
                HStack {
                    Text("Y:").foregroundStyle(.white)
                    
                    Slider(value: $angularCenterPointY, in: 0...1)
                }
                
            }.textFieldStyle(.plain)
            HStack {
                Text("Start Angle").font(.callout)
                    .foregroundStyle(.white)
                Spacer()
                Slider(value: $angularStartAngle, in: 0...360)
            }
            HStack {
                Text("End Angle").font(.callout)
                    .foregroundStyle(.white)
                Spacer()
                Slider(value: $angularEndAngle, in: 0...360)
                
            }
        }
        
    }
    
    var ellipticalSettingsView: some View {
        VStack {
            Text("Elliptical Gradient Settings").font(.largeTitle)
                .foregroundStyle(.white)
                .padding(.vertical)
            HStack {
                Text("Center Point").font(.callout)
                    .foregroundStyle(.white)
                Spacer()
                HStack {
                    Text("X:").foregroundStyle(.white)
                    Slider(value: $ellipticalCenterPointX, in: 0...1)
                }
                
                HStack {
                    Text("Y:").foregroundStyle(.white)
                    
                    Slider(value: $ellipticalCenterPointY, in: 0...1)
                }
                
                
                
            }.textFieldStyle(.plain)
            HStack {
                Text("Start Radius").font(.callout)
                    .foregroundStyle(.white)
                Spacer()
                Slider(value: $startRadiusFraction, in: 0...1)
                
            }
            HStack {
                Text("End Radius").font(.callout)
                    .foregroundStyle(.white)
                Spacer()
                Slider(value: $endRadiusFraction, in: 0...1)
            }
        }
        
    }
    
    var linearSettingsView: some View {
        VStack {
            Text("Linear Gradient Settings").font(.largeTitle)
                .foregroundStyle(.white)
                .padding(.vertical)
            HStack {
                Text("Start Point").font(.callout)
                    .foregroundStyle(.white)
                Spacer()
                HStack {
                    Text("X:").foregroundStyle(.white)
                    
                    Slider(value: $linearStartPointX, in: 0...1)
                }
                
                HStack {
                    Text("Y:").foregroundStyle(.white)
                    
                    Slider(value: $linearStartPointY, in: 0...1)
                }
                
            }
            HStack {
                Text("End Point").font(.callout)
                    .foregroundStyle(.white)
                Spacer()
                HStack {
                    Text("X:").foregroundStyle(.white)
                    
                    Slider(value: $linearEndPointX, in: 0...1)
                }
                
                HStack{
                    Text("Y:").foregroundStyle(.white)
                    
                    Slider(value: $linearEndPointY, in: 0...1)
                }
                
                
            }
        }
        
    }
    
    var radialSettingsView: some View {
        VStack {
            Text("Radial Gradient Settings").font(.largeTitle)
                .foregroundStyle(.white)
                .padding(.vertical)
            HStack {
                Text("Center Point").font(.callout)
                    .foregroundStyle(.white)
                Spacer()
                
                HStack {
                    Text("X:").foregroundStyle(.white)
                    
                    Slider(value: $radialCenterXPoint, in: 0...1)
                }
                
                HStack {
                    Text("Y:").foregroundStyle(.white)
                    
                    Slider(value: $radialCenterYPoint, in: 0...1)
                }
                
                
            }
            HStack {
                Text("Start Radius").font(.callout)
                    .foregroundStyle(.white)
                Spacer()
                Slider(value: $radialStartRadius, in: 0...360)
            }
            HStack {
                Text("End Radius").font(.callout)
                    .foregroundStyle(.white)
                Spacer()
                Slider(value: $radialEndRadius, in: 0...360)
            }
        }
    }
    
    
    var headerAndButton: some View {
        HStack(alignment: .center) {
            Text("\(type.returnTextDescription())")
                .font(.largeTitle)
                .fontWeight(.thin)
                .foregroundStyle(Color.white)
            Spacer()
            Button{
                withAnimation(.easeInOut(duration: 1)) {
                    if showBottomDrawer {
                        showBottomDrawer.toggle()
                    }
                    showTopDrawer.toggle()
                    
                }
            } label: {
                
                CircleButtonView(gradient: colorManager.selectedGradient.gradient)
                    .overlay {
                        Image(systemName: "chevron.down")
                            .foregroundStyle(.white)
                            .rotationEffect(.degrees(showList ? 180 : 0))
                    }
            }
        }
    }
    
    var topGlass: some View {
        List {
            ForEach(colorManager.gradients, id: \.id) { item in
                Button {
                    withAnimation(.easeInOut(duration: 0.3), completionCriteria: .logicallyComplete) {
                        selectedGradientRow = item
                        colorManager.selectedGradient = item
                        
                    } completion: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            selectedGradientRow = nil
                            showTopDrawer.toggle()
                        }
                    }
                } label: {
                    HStack {
                        Text(item.name)
                            .font(.largeTitle)
                            .fontWeight(.light)
                            .foregroundStyle(.white)
                        
                        ZStack(alignment: .trailing) {
                            LinearGradient(gradient: item.gradient, startPoint: .leading, endPoint: .trailing)
                                .frame(height: colorManager.selectedGradient == item ? 44 : 10)
                                .opacity(colorManager.selectedGradient == item ? 0.8 : 0.2)
                                .clipShape(Capsule())
                            CircleButtonView(gradient: item.gradient)
                                .frame(width: 40, height: 40)
                        }
                    }.frame(width: UIScreen.screenWidth - 32)
                    
                }.contentShape(Rectangle())
                
            }.listRowBackground(Color.clear)
            
        }.frame(height: showTopDrawer ? listHeight : 0)
            .listStyle(.plain)
    }
    
    var content: some View {
        VStack(alignment: .leading) {
            ZStack {
                Text("")
            }
            Spacer()
            //                .frame(height: showList ? 0 : UIScreen.screenHeight - 420)
        }
        
        .onChange(of: showTopDrawer) { oldValue, newValue in
            if oldValue == false {
                listHeight = UIScreen.screenHeight - 290
                withAnimation(.easeInOut(duration: 0.2), completionCriteria: .removed) {
                    if showBottomDrawer {
                        showBottomDrawer = false
                    }
                } completion: {
                    withAnimation(.easeInOut(duration: 0.2)){
                        
                        showList = true
                        
                        currentTopDrawerHeight = UIScreen.screenHeight - 140
                    }
                }
            }
            if oldValue == true {
                withAnimation(.easeInOut(duration: 0.2)){
                    showList = false
                    listHeight = 0
                    currentTopDrawerHeight = 140
                }
            }
        }
        .onChange(of: showBottomDrawer) { oldValue, newValue in
            if oldValue == false {
                withAnimation(.easeInOut(duration: 0.2), completionCriteria: .removed) {
                    if showTopDrawer {
                        showList = false
                        listHeight = 0
                        currentTopDrawerHeight = 140
                    }
                } completion: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        sheetViewType = .halfScreen
                    }
                }
                
            }
            if oldValue == true {
                withAnimation(.easeInOut(duration: 0.2)) {
                    
                    sheetViewType = .none
                    
                }
            }
            
        }
    }
    
    var background: some View {
        ZStack {
            switch type {
            case .angular:
                angularView
            case .elliptical:
                ellipticalView
            case .linear:
                linearView
            case .radial:
                radialView
            }
        }
        .ignoresSafeArea()
    }
    
    
}
