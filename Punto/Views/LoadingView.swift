//
//  LoadingView.swift
//  Punto
//
//  Created by Sebastian Garcia on 14/03/26.
//

import SwiftUI
import Combine

struct LoadingView: View {
    private let appName = ["P","u","n","t","o"]
    @State private var revealedCount: Int = 0
    @State private var timerCancellable: AnyCancellable?
    @State private var isPulsing: Bool = false
    @State private var showImage: Bool = false

    var body: some View {

        VStack(alignment: .center) {
            if showImage {
                Image("app")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .animation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: isPulsing)
                    .padding(.bottom, 8)
                    .transition(.asymmetric(insertion: .scale.combined(with: .opacity),
                                            removal: .opacity))
            }
            HStack(spacing: 4) {
                ForEach(Array(appName.enumerated()), id: \.offset) { index, letter in
                    Text(letter)
                        .font(.largeTitle).bold()
                        .opacity(index < revealedCount ? 1 : 0.2)
                        .animation(.easeInOut(duration: 0.25), value: revealedCount)
                }
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.2)) {
                showImage = true
            }
            // Start pulsing after it's visible
            isPulsing = true
            // Publish a tick every 0.3s to reveal letters in sequence, then loop
            timerCancellable = Timer.publish(every: 0.3, on: .main, in: .common)
                .autoconnect()
                .sink { _ in
                    if revealedCount < appName.count {
                        revealedCount += 1
                    } else {
                        // Reset to create a looping effect
                        revealedCount = 0
                    }
                }
        }
        .onDisappear {
            withAnimation(.easeInOut(duration: 0.2)) {
                showImage = false
            }
            isPulsing = false
            timerCancellable?.cancel()
            timerCancellable = nil
        }
    }
}

#Preview {
    LoadingView()
}
