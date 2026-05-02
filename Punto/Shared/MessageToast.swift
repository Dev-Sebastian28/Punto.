import SwiftUI

struct MessageToast: View {
    let message: String
    var body: some View {
        HStack(spacing: 10) {
            Text(message)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.primary)
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(.regularMaterial)
                .shadow(color: .black.opacity(0.12), radius: 12, x: 0, y: 4)
        )
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }
}
