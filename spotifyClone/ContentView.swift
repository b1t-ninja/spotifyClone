//
//  ContentView.swift
//  spotifyClone
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct ContentView: View {
    @State private var users: [User] = []
    @State private var products: [Product] = []
    var body: some View {
        ScrollView {
            ForEach(products) { user in
                Text(user.title)
            }
        }
        .task {
                await getData()
            }
    }
    
    private func getData() async {
        do {
            users = try await DatabaseHelper().getUsers()
            products = try await DatabaseHelper().getProducts()
        } catch {
            
        }
    }
}

#Preview {
    ContentView()
}
