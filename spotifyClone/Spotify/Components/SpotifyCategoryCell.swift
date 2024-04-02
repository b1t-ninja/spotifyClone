//
//  SpotifyCategoryCell.swift
//  spotifyClone
//
//

import SwiftUI

struct SpotifyCategoryCell: View {
    var title: String = "All"
    var isSelected: Bool = false
    var body: some View {
        Text(title)
            .font(.callout)
            .frame(minWidth: 35)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .background(isSelected ? .spotifyGreen : .spotifyDarkGray)
            .foregroundStyle(isSelected ? .spotifyBlack : .spotifyWhite)
            .cornerRadius(16)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack(spacing: 40) {
            SpotifyCategoryCell(title: "Title goes here")
            SpotifyCategoryCell(isSelected: true)
            SpotifyCategoryCell(title: "Title goes here", isSelected: true)
        }
    }
}
