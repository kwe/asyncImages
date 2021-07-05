//
//  ContentView.swift
//  Shared
//
//  Created by Kevin Evans on 05/07/2021.
//

import SwiftUI

@available(iOS 15.0, *)
struct ContentView: View {
    
    private var url = URL(string: "https://picsum.photos/220")
    private let transaction: Transaction = .init(animation: .linear)
    
    
    var body: some View {
        List {
            ForEach(0..<10) { _ in
                AsyncImage(url: url,
                           transaction: transaction,
                           content: view)

                    .listRowInsets(.init(.zero))
            }
        }
        .listStyle(.plain)
        
    }
    @ViewBuilder
    private func view(for phase: AsyncImagePhase) -> some View {
        switch phase {
        case .empty:
            ProgressView()
        case .success(let image):
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        case .failure(let error):
            VStack(spacing: 16) {
                Image(systemName: "xmark.octagon.fill")
                    .foregroundColor(.red)
                Text(error.localizedDescription)
                    .multilineTextAlignment(.center)
            }
        @unknown default:
            Text("Unknown")
                .foregroundColor(.gray)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            ContentView()
        } else {
            // Fallback on earlier versions
        }
    }
}
