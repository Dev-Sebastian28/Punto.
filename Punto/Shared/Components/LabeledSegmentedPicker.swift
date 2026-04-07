//
//  LabeledSegmentedPicker.swift
//  Punto
//
//  Created by Sebastian Garcia on 1/04/26.
//
import SwiftUI

struct LabeledSegmentedPicker<SelectionValue: Hashable, Content: View>: View {
    let title: String
    @Binding var selection: SelectionValue
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .center, spacing: 6) {
            Text(title)
                .font(.system(size: 14, weight: .bold))

            Picker(title, selection: $selection) {
                content
            }
            .pickerStyle(.segmented)
            .frame(height: 40)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
