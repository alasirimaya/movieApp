//
//  Account.swift
//  movieApp
//
//  Created by maya alasiri  on 26/07/1446 AH.
//
import SwiftUI

struct Account: View {
    var body: some View {
        ZStack {
            // Black background
            Color.black.ignoresSafeArea()
            
            // Content
            Text("Profile")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .offset(x: 16, y: 100) // Offset the text
        }
        .navigationTitle("Account") // Title for the Account view
        .navigationBarTitleDisplayMode(.inline) // Inline navigation title
    }
}

// MARK: - Preview
#Preview {
    NavigationView {
        Account()
    }
}
