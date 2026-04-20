//
//  SelectedInfoComp.swift
//  Punto
//
//  Created by Sebastian Garcia on 20/04/26.
//

import SwiftUI

struct SelectedInfoComp: View {
    let model: String
    let plate: String
    let total: String
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(model)
                .font(.title2.bold())

            HStack {
                Text(plate)
                    .font(.callout)
                    .foregroundStyle(.gray)

                Spacer()

                Text("\(total) Total")
                    .font(.callout).bold()
                    .foregroundStyle(.gray)
            }
        }
    }
}
