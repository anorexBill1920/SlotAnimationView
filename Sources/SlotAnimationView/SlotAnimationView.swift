// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

struct SlotAnimationView<T: Identifiable & Hashable, Content: View>: View {
    var items: [T]
    @Binding var restartAnimation: Bool
    let content: (T) -> Content

    init(items: [T], restartAnimation: Binding<Bool>, @ViewBuilder content: @escaping (T) -> Content) {
        self.items = items
        self._restartAnimation = restartAnimation
        self.content = content
    }

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size.height

            InfiniteScroller(numItems: items.count, contentHeight: size, delay: 0.1, restartAnimation: $restartAnimation) {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(items, id: \.self) { item in
                        self.content(item)
                    }
                }
                .padding(0)
            }
        }
        .onTapGesture {
            restartAnimation.toggle()
        }
    }
}
