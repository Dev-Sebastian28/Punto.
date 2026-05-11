//
//  CargoDueDateView.swift
//  Punto
//
//  Created by Sebastian Garcia on 6/05/26.
//

import SwiftUI

struct CargoDueDateView: View {
    let cargo: Cargo
    var body: some View {
        VStack(alignment: .leading) {
            CardHeader(icon: "calendar", title: "Cargo Due Date", color: .red)

            InfoRow(label: "Created at:", value: "\(cargo.createdAt)")
            InfoRow(label: "Deadline:", value: "\(cargo.dueDate)")

            Divider()

            DescriptionBlock(
                icon: "text.alignleft",
                text: "\(cargo.origin)."
            )
        }.genericRoundedBackgroundShadow(color: .gray)
    }
}

#Preview {
    CargoDueDateView(cargo: .mockPending)
}
