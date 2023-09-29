//
//  File.swift
//  
//
//  Created by Frimpong Anorchie II on 2023-09-29.
//

import Foundation
import SwiftUI

@available(iOS 14.0, *)
struct InfiniteScroller<Content: View>: View {
    var numItems: Int
    var contentHeight: CGFloat
    var delay: Double
    @Binding var restartAnimation: Bool
    var content: (() -> Content)
    
    @State var yOffset: CGFloat = 0
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack(spacing: 0) {
                content()
                content()
            }
            .offset(x: 0, y: yOffset)
        }
        .disabled(true)
        .onAppear {
            if restartAnimation {
                startScrollAnimation()
            }
        }
        .onChange(of: restartAnimation) { newValue in
            if newValue {
                startScrollAnimation()
            }
        }
    }
    
    func startScrollAnimation() {
        yOffset = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            withAnimation(.easeOut(duration: 3)) {
                yOffset -= contentHeight * CGFloat(numItems - 1)
            }
        }
        restartAnimation = false
    }
}
