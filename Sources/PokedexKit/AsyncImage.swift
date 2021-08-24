//
//  AsyncImage.swift
//  pokedex
//
//  Created by Magnus Jensen on 12/08/2021.
//

import SwiftUI
import URLImage
import URLImageStore

let urlImageService = URLImageService(fileStore: nil, inMemoryStore: URLImageInMemoryStore())


public struct AsyncImage<Content: View>: View {
    
    let url: URL
    @ViewBuilder let content: (Image) -> Content
    
    public init(_ url: URL, content: @escaping (Image) -> Content) {
        self.url = url
        self.content = content
    }
    
    public var body: some View {
        URLImage(url, content: content)
            .environment(\.urlImageService, urlImageService)
    }
}
