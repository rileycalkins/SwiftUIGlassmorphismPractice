////
////  BottomSheetAdvancedView.swift
////  GlassmorphismPractice
////
////  Created by Riley Calkins on 12/19/23.
////
//
import SwiftUI

fileprivate enum Constants {
    static let radius: CGFloat = 16
    static let indicatorHeight: CGFloat = 6
    static let indicatorWidth: CGFloat = 60
    static let snapRatio: CGFloat = 0.25
    static let minHeightRatio: CGFloat = 0.3
}


public enum BottomSheetDisplayType {
    case fullScreen
    case halfScreen
    case none
}

public enum TopSheetDisplayType {
    case fullScreen
    case halfScreen
    case none
}

struct BottomSheetAdvanceView<Content: View>: View {
    @Binding var displayType: BottomSheetDisplayType
    @Binding var showBottomDrawer: Bool
    @Binding var gr: IdGradient
    @Binding var showTopSheet: Bool
    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content
    
    @GestureState private var translation: CGFloat = 0
    //MARK:- Offset from top edge
    private var offset: CGFloat {
        switch displayType {
        case .fullScreen :
            return 0
        case .halfScreen :
            return maxHeight * 0.60
        case .none :
            return maxHeight - minHeight
        }
        
    }
    
    private var indicator: some View {
        Capsule()
            .frame(width: 50, height: 3)
            .foregroundStyle(gr.gradient.opacity(0.4))
            .onTapGesture {
                //            self.isOpen.toggle()
            }
    }
    
    init(gr: Binding<IdGradient>, show: Binding<Bool>, showTopSheet: Binding<Bool> ,displayType: Binding<BottomSheetDisplayType>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self.minHeight = 40
        self.maxHeight = maxHeight
        self.content = content()
        self._displayType = displayType
        self._showBottomDrawer = show
        self._gr = gr
        self._showTopSheet = showTopSheet
    }
    
    var body: some View {
        GeometryReader { geometry in
            ThinGlassWindowView(alignment: .top) {
                self.indicator
                    .offset(y: -10)
                self.content
                    .offset(y: translation / 4)
            }
            .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0))
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                    if showTopSheet {
                        showTopSheet.toggle()
                    }
                }.onEnded { value in
                    
                    if value.translation.height < 100 {
                        self.displayType = .halfScreen
                        withAnimation(.easeInOut(duration: 0.2)) {
                            showBottomDrawer = true
                        }
                    }
                    else {
                        showBottomDrawer = false
                        self.displayType = .none
                    }
                }
            )
        }
    }
}


struct TopSheetAdvanceView<Content: View>: View {
    @Binding var displayType: TopSheetDisplayType
    @Binding var showTopDrawer: Bool
    @Binding var gr: IdGradient
    @Binding var currentHeight: CGFloat
    @Binding var showList: Bool
    @Binding var showBottomSheet: Bool
    
    var closedHeight: CGFloat = 140
    var openHeight = UIScreen.screenHeight - 250
    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content
    
    @GestureState private var translation: CGFloat = 0
    //MARK:- Offset from top edge
    private var offset: CGFloat {
        switch displayType {
        case .fullScreen :
            return 0
        case .halfScreen :
            return maxHeight
        case .none :
            return maxHeight - minHeight
        }
        
    }
    
    private var indicator: some View {
        Capsule()
            .frame(width: 50, height: 3)
            .foregroundStyle(gr.gradient.opacity(0.4))
            .onTapGesture {
                //            self.isOpen.toggle()
            }
    }
    
    init(gr: Binding<IdGradient>, show: Binding<Bool>, showList: Binding<Bool>, showBottomSheet: Binding<Bool> ,currentHeight: Binding<CGFloat>, displayType: Binding<TopSheetDisplayType>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self.minHeight = 140
        self.maxHeight = maxHeight
        self.content = content()
        self._displayType = displayType
        self._showTopDrawer = show
        self._gr = gr
        self.closedHeight = 140
        self.openHeight = UIScreen.screenHeight - 140
        self._currentHeight = currentHeight
        self._showList = showList
        self._showBottomSheet = showBottomSheet
    }
    
    var body: some View {
        GeometryReader { geometry in
            ThinGlassWindowView(alignment: .bottom) {
                indicator
                    .offset(y: 10)
                self.content
//                    .offset(y: translation * 2)
            }
            .frame(width: geometry.size.width, height: self.currentHeight + self.translation, alignment: .top)
            .frame(height: geometry.size.height + maxHeight, alignment: .top)
//            .offset(y: max(self.offset + self.translation, 0))
//            .offset(y: max(self.translation, 0))
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                    if showBottomSheet{
                        showBottomSheet.toggle()
                    }
                }.onEnded { value in
                    if value.translation.height > 100 {
                        currentHeight = openHeight
                        showTopDrawer = true
                    }
                    else {
                        currentHeight = closedHeight
                        showTopDrawer = false
                    }
                }
            )
        }
    }
}
