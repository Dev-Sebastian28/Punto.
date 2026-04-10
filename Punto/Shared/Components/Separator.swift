//
//  Separator.swift
//  Punto
//
//  Created by Sebastian Garcia on 27/03/26.
//

import SwiftUI

struct Separator: View {
    let color: Color = .gray
    var body: some View {
        // Separator
        RoundedRectangle(cornerRadius: .infinity)
            .frame(height: 1)
            .foregroundStyle(color)
            .padding(.horizontal,2)
            .padding(.vertical,4)

    }
}

#Preview {
    Separator()
}
