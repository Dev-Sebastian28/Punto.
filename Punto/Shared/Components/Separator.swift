//
//  Separator.swift
//  Punto
//
//  Created by Sebastian Garcia on 27/03/26.
//

import SwiftUI

struct Separator: View {
    var body: some View {
        // Separator
        Rectangle()
            .frame(height: 1)
            .foregroundStyle(.gray)
            .padding(.horizontal,2)
            .padding(.vertical,4)

    }
}

#Preview {
    Separator()
}
