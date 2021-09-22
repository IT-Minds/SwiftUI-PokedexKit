//
//  SwiftUIView.swift
//  
//
//  Created by Magnus Jensen on 24/08/2021.
//

import SwiftUI

public struct PKBackground: View {
    
    @State private var size: CGSize = .zero
    
    let caught: Bool
    
    public init(caught: Bool) {
        self.caught = caught
    }
    
    public var body: some View {
        ZStack {
            if caught {
                Circle()
                    .trim(from: 0.0, to: 0.5)
                    .fill(Color.white)
                Circle()
                    .trim(from: 0.5, to: 1.0)
                    .fill(Color.red)
                Rectangle()
                    .fill(Color.black)
                    .frame(height: size.width / 40)
                Circle()
                    .fill(Color.white)
                    .frame(width: size.width / 4, height: size.width / 3)
                Circle()
                    .stroke(Color.black, lineWidth: size.width / 40)
                    .frame(width: size.width / 4, height: size.width / 3)
                Circle()
                    .strokeBorder(Color.black, lineWidth: size.width / 20, antialiased: true)
            } else {
                Color.gray.opacity(0.25)
            }
        }
        .mask(Circle())
        .background(spy)
    }
    
    private var spy: some View {
        GeometryReader { proxy in
            Color.clear
                .onAppear {
                    self.size = proxy.size
                }
                .onChange(of: proxy.size) {
                    self.size = $0
                }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        PKBackground(caught: true)
    }
}
