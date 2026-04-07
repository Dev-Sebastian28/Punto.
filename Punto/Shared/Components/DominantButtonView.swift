//
//  DominantButtonView.swift
//  Punto
//
//  Created by Sebastian Garcia on 30/03/26.
//

import SwiftUI

struct DominantButtonView: View {
    enum Style {
        case dominant
        case neutral
    }

    let text: String
    let color: Color
    let image: String?
    var style: Style = .dominant
    var maxWidth: CGFloat? = nil
    var isEnabled: Bool = true
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Text(text)

                if let image {
                    Image(systemName: image)
                }
            }
            .font(labelFont)
            .foregroundStyle(foregroundColor)
            .frame(maxWidth: maxWidth ?? .infinity)
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
            .background(backgroundStyle)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(borderColor, lineWidth: borderWidth)
            }
            .shadow(color: shadowColor, radius: shadowRadius, x: 0, y: shadowYOffset)
            .contentShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .opacity(isEnabled ? 1 : 0.55)
        }
        .buttonStyle(AnimatedPressButtonStyle())
        .disabled(!isEnabled)
    }

    private var labelFont: Font {
        switch style {
        case .dominant:
            .title3.weight(.semibold)
        case .neutral:
            .headline.weight(.medium)
        }
    }

    private var foregroundColor: Color {
        switch style {
        case .dominant:
            .white
        case .neutral:
            .secondary
        }
    }

    private var backgroundStyle: AnyShapeStyle {
        switch style {
        case .dominant:
            AnyShapeStyle(
                LinearGradient(
                    colors: [color, color.opacity(0.8)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
        case .neutral:
            AnyShapeStyle(Color.platformGray6)
        }
    }

    private var borderColor: Color {
        switch style {
        case .dominant:
            .white.opacity(0.2)
        case .neutral:
            .clear
        }
    }

    private var borderWidth: CGFloat {
        style == .dominant ? 1 : 0
    }

    private var shadowColor: Color {
        switch style {
        case .dominant:
            color.opacity(0.25)
        case .neutral:
            .clear
        }
    }

    private var shadowRadius: CGFloat {
        style == .dominant ? 10 : 0
    }

    private var shadowYOffset: CGFloat {
        style == .dominant ? 6 : 0
    }

    private var verticalPadding: CGFloat {
        style == .dominant ? 12 : 10
    }

    private var horizontalPadding: CGFloat {
        style == .dominant ? 22 : 16
    }

    private var cornerRadius: CGFloat {
        style == .dominant ? 12 : 12
    }
}

private struct AnimatedPressButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .brightness(configuration.isPressed ? -0.06 : 0)
            .animation(.spring(response: 0.22, dampingFraction: 0.72), value: configuration.isPressed)
    }
}

#Preview {
    VStack(spacing: 16) {
        DominantButtonView(text: "Add", color: .green, image: "plus") {
        }

        DominantButtonView(
            text: "Cancel",
            color: .gray,
            image: "xmark",
            style: .neutral,
            maxWidth: 120
        ) {
        }
    }
    .padding()
}
