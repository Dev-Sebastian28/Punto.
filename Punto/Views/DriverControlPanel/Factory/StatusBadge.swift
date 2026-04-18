import SwiftUI

struct StatusBadge: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .font(.subheadline.bold())
            .foregroundStyle(.white)
            .padding(.vertical, 2)
            .padding(.horizontal, 12)
            .background(color.clipShape(.capsule))
    }
}

struct DateBadge: View {
    let date: Date

    var body: some View {
        Text(date.formatted(.dateTime.day().month()))
            .padding(.vertical, 2)
            .padding(.horizontal, 6)
            .background(Capsule().stroke(.blue))
    }
}