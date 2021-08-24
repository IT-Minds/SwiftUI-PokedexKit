//
//  Catchable.swift
//  pokedex
//
//  Created by Magnus Jensen on 23/08/2021.
//

import SwiftUI

public extension View {
    @ViewBuilder
    func catchable(when catching: Bool, _ action: (() -> Void)? = nil) -> some View {
        self.modifier(EnableCatch(enable: catching, action: action ?? {}))
    }
}

struct EnableCatch: ViewModifier {
    
    let enable: Bool
    let action: () -> Void
    
    @State private var forceRemove = false
    
    func body(content: Content) -> some View {
        content
            .overlay {
                Color.clear
                    .modifier(Catchable {
                        action()
                        forceRemove = true
                    })
                    .opacity(show ? 1 : 0)
                    .disabled(!show)
            }
    }
    
    private var show: Bool {
        enable && !forceRemove
    }
}

struct Catchable: ViewModifier {
    
    let action: () -> Void
    
    @State private var degree: Double = 0
    @State private var size: CGSize = .zero
    
    @State private var up = true
    
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    @GestureState private var running: Bool = false
    
    let style = StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round, miterLimit: 0, dash: [1], dashPhase: 10)
    
    @State private var hitTarget: Int = (10...170).randomElement()!
    
    private var mapped: CGFloat {
        CGFloat(hitTarget) / (180.0 * 2) + 0.5
    }
    
    func body(content: Content) -> some View {
        content
            .contentShape(Rectangle())
            .padding()
            .overlay {
                Circle().trim(from: 0.5, to: 1.0).stroke(Color.blue, style: style)
            }
            .overlay {
                Circle().trim(from: mapped - 0.01, to: mapped + 0.01).stroke(Color.red, style: style)
            }
            .background(spy)
            .overlay {
                Path {
                    $0.move(to: CGPoint(x: size.width / 2, y: size.height / 2))
                    $0.addLine(to: CGPoint(x: 0, y: size.width / 2))
                }
                .stroke(Color.green.opacity(0.75), style: style)
                .rotationEffect(.degrees(degree), anchor: .center)
            }
            .gesture(gesture)
            .onReceive(timer) { _ in
                if self.running {
                    withAnimation(.easeInOut(duration: 0.01)) {
                        let multi = up ? 1.0 : -1.0
                        degree += multi
                        if degree == 180 {
                            up = false
                        } else if degree == 0 {
                            up = true
                        }
                    }
                }
            }
    }
    
    private var covers: Bool {
        let current = Double(degree) / (180.0 * 2) + 0.5
        return Double(mapped) - 0.01 <= current && current <= Double(mapped) + 0.01
    }
    
    private var gesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .updating($running) { action, state, transaction in
                state = true
            }
            .onEnded { _ in
                if !covers {
                    degree = 0
                    up = true
                    hitTarget = (10...170).randomElement()!
                }
                if covers {
                    action()
                }
            }
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

extension View {
    func overlay<Overlay: View>(alignment: Alignment = .center, @ViewBuilder content: () -> Overlay) -> some View {
        self.overlay(content(), alignment: alignment)
    }
}

struct Catchable_Previews: PreviewProvider {
    static var previews: some View {
        Image(systemName: "star")
            .resizable()
            .frame(width: 200, height: 200, alignment: .center)
    }
}
