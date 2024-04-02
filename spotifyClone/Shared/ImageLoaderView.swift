//
//  ImageLoaderView.swift
//  spotifyClone
//
//
//  ContentView.swift
//  spotifyClone
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {
    
    // why var ?
    // with var we get an implicit initializer
    var urlString: String = "https://picsum.photos/600/600"
    var resizingMode: ContentMode = .fill
    
    var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay(
        WebImage(url: URL(string: urlString))
            .resizable()
            .indicator(.activity)
            .aspectRatio(contentMode: resizingMode)
        // in order to avoid users being able to tap the image, we need to add this little line of code :)
            .allowsHitTesting(false)
            )
            .clipped()
    }
}

#Preview {
    ImageLoaderView()
        .cornerRadius(30)
        .padding(40)
        .padding(.vertical, 60)
}
