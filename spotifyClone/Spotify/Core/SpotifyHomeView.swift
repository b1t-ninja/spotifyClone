//
//  SpotifyHomeView.swift
//  spotifyClone
//
//

import SwiftUI
import SwiftfulUI

struct SpotifyHomeView: View {
    @State private var currentUser: User? = nil
    @State private var selectedCategory: Category? = nil
    @State private var products: [Product] = []
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            ScrollView(.vertical) {
                LazyVStack(spacing: 16, pinnedViews: [.sectionHeaders]) {
                    
                    Section {
                        VStack(spacing: 16) {
                            recentsSection
                            // tripple click the name and then press control + m to format
                            if let firstProduct = products.first {
                                newReleaseSection(firstProduct: firstProduct)
                            }
                        }
                        .padding(.horizontal, 16)
                        ForEach(0..<20) {_ in
                            Rectangle()
                                .frame(width: 200, height: 200)
                            }
                    } header: {
                        header
                    }
                }
                .padding(.top, 8)
            }
            .scrollIndicators(.hidden)
            .clipped()
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func getData() async {
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            products = try await Array(DatabaseHelper().getProducts().prefix(8)) // gives subsequence of the first 8 elems
        } catch {}
    }
    
    private var header: some View {
        HStack(spacing: 0) {
            ZStack {
                if let currentUser {
                    ImageLoaderView(urlString: currentUser.image)
                        .frame(width: 30, height: 30)
                        .background(.spotifyWhite)
                        .clipShape(Circle())
                        .onTapGesture {
                            // TODO!
                        }
                }
            }
            .frame(width: 35, height: 35)
            
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(Category.allCases, id: \.self) { category in
                        SpotifyCategoryCell(title: category.rawValue.capitalized, isSelected: category == selectedCategory)
                            .onTapGesture {
                                selectedCategory = category
                            }
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.vertical, 24)
        .padding(.leading, 8)
        .background(.spotifyBlack)
    }
    private var recentsSection: some View {
        NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: products) { product in
            if let product {
                SpotifyRecentsCell(imageName: product.firstImage, title: product.title)
            }
        }
    }
    
    private func newReleaseSection(firstProduct: Product) -> some View {
        SpotifyNewReleaseCell(
            imageName: firstProduct.firstImage,
            headline: firstProduct.brand,
            subHeadline: firstProduct.category,
            title: firstProduct.title,
            subtitle: firstProduct.description,
            onAddToPlaylistPressed: nil,
            onPlayPressed: nil
        )
    }
}

#Preview {
    SpotifyHomeView()
}
