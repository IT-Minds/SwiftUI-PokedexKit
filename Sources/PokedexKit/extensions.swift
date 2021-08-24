//
//  extensions.swift
//  pokedex
//
//  Created by Magnus Jensen on 12/08/2021.
//

import SwiftUI

extension View {
    func background<Content: View>(alignment: Alignment = .leading, @ViewBuilder content: () -> Content) -> some View {
        self.background(content(), alignment: alignment)
    }
}

