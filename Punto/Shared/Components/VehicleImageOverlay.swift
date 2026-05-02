//
//  VehicleImageOverlay.swift
//  Punto
//
//  Created by Sebastian Garcia on 30/04/26.
//


//
//  VehicleImageView.swift
//  Punto
//
//  Created by Sebastian Garcia on 30/04/26.
//
 
import SwiftUI
 
// MARK: - Overlay Content Protocol
 
/// Defines content that can be displayed as an overlay on VehicleImageView.
protocol VehicleImageOverlay: View {}
 
// MARK: - Built-in Overlay Styles
 
/// Overlay with brand + plate info (used in VehicleInformationView).
struct VehicleNameOverlay: View, VehicleImageOverlay {
    let brand: String
    let model: String
    let plate: String
 
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(brand) \(model)")
                .font(.title2.bold())
            Text(plate)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white.opacity(0.9))
        }
        .foregroundStyle(.white)
        .padding(16)
    }
}
 
/// Overlay with a single centered label (e.g. a status badge).
struct VehicleStatusOverlay: View, VehicleImageOverlay {
    let label: String
    let color: Color
 
    var body: some View {
        Text(label)
            .font(.headline.bold())
            .foregroundStyle(.white)
            .padding(.horizontal, 18)
            .padding(.vertical, 10)
            .background(color.opacity(0.85))
            .clipShape(Capsule())
    }
}
 
// MARK: - Main Component
 
/// A flexible, reusable vehicle image with an optional gradient overlay.
///
/// Usage examples:
///
/// ```swift
/// // Fixed height, name overlay at bottom-leading
/// VehicleImageView(imageUrl: info.imageUrl, height: 200) {
///     VehicleNameOverlay(brand: info.brand, model: info.model, plate: info.plate)
/// }
///
/// // Thumbnail with no overlay
/// VehicleImageView(imageUrl: info.imageUrl, height: 80)
///
/// // Full-width hero image with custom content
/// VehicleImageView(imageUrl: info.imageUrl, height: 320, cornerRadius: 0) {
///     Text("🔥 Hot Deal").font(.largeTitle)
/// }
/// ```
struct VehicleImageView<Overlay: View>: View {
 
    // MARK: - Configuration
 
    let imageUrl: String?
    var height: CGFloat = 200
    var cornerRadius: CGFloat = 20
    var overlayAlignment: Alignment = .bottomLeading
    var showGradient: Bool = true
    var gradientOpacity: Double = 0.55
 
    @ViewBuilder var overlayContent: () -> Overlay
 
    // MARK: - Convenience init (no overlay)
 
    init(
        imageUrl: String?,
        height: CGFloat = 200,
        cornerRadius: CGFloat = 20
    ) where Overlay == EmptyView {
        self.imageUrl = imageUrl
        self.height = height
        self.cornerRadius = cornerRadius
        self.showGradient = false
        self.overlayContent = { EmptyView() }
    }
 
    // MARK: - Full init
 
    init(
        imageUrl: String?,
        height: CGFloat = 200,
        cornerRadius: CGFloat = 20,
        overlayAlignment: Alignment = .bottomLeading,
        showGradient: Bool = true,
        gradientOpacity: Double = 0.55,
        @ViewBuilder overlayContent: @escaping () -> Overlay
    ) {
        self.imageUrl = imageUrl
        self.height = height
        self.cornerRadius = cornerRadius
        self.overlayAlignment = overlayAlignment
        self.showGradient = showGradient
        self.gradientOpacity = gradientOpacity
        self.overlayContent = overlayContent
    }
 
    // MARK: - Body
 
    var body: some View {
        imageContent
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(alignment: overlayAlignment) {
                if showGradient {
                    gradientLayer
                }
            }
            .overlay(alignment: overlayAlignment) {
                overlayContent()
            }
    }
 
    // MARK: - Subviews
 
    @ViewBuilder
    private var imageContent: some View {
        if let urlString = imageUrl, let url = URL(string: urlString) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    placeholder
                        .overlay(ProgressView())
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    placeholder
                        .overlay {
                            Image(systemName: "photo.slash")
                                .foregroundStyle(.secondary)
                        }
                @unknown default:
                    placeholder
                }
            }
        } else {
            placeholder
                .overlay {
                    Image(systemName: "car.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.secondary)
                }
        }
    }
 
    private var placeholder: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.15))
    }
 
    private var gradientLayer: some View {
        LinearGradient(
            colors: [.clear, .black.opacity(gradientOpacity)],
            startPoint: .top,
            endPoint: .bottom
        )
        .allowsHitTesting(false)
    }
}
 
// MARK: - Preview
 
#Preview("Name overlay — large") {
    VehicleImageView(
        imageUrl: "https://picsum.photos/600/400",
        height: 220
    ) {
        VehicleNameOverlay(brand: "Volvo", model: "X700x", plate: "DMW-243")
    }
    .padding()
}
 
#Preview("Status overlay — centered") {
    VehicleImageView(
        imageUrl: "https://picsum.photos/600/400",
        height: 180,
        overlayAlignment: .center,
        showGradient: false
    ) {
        VehicleStatusOverlay(label: "Disponible", color: .green)
    }
    .padding()
}
 
#Preview("Thumbnail — no overlay") {
    VehicleImageView(imageUrl: "https://picsum.photos/200/150", height: 80, cornerRadius: 12)
        .padding()
}
 
#Preview("No URL — fallback") {
    VehicleImageView(imageUrl: nil, height: 160)
        .padding()
}
