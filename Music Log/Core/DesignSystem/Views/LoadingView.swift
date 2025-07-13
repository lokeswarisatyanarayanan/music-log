//
//  LoadingView.swift
//  Music Log
//
//  Created by Lokeswari on 05/07/25.
//

import SwiftUI
import Iconoir

struct LoadingView: View {
    @Environment(\.theme) private var theme
    
    @State private var pulseScale: CGFloat = 0.8
    @State private var pulseOpacity: CGFloat = 0.2
    @State private var sparklePulse = false
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            
            ZStack {
                backgroundCircles(size: size, center: center)
                sparkles(size: size, center: center)
                musicNotes(size: size, center: center)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .onAppear {
                withAnimation(
                    Animation.timingCurve(0.4, 0.0, 0.2, 1.0, duration: 0.9)
                        .repeatForever(autoreverses: true)
                ) {
                    pulseScale = 1.0
                    pulseOpacity = 0.3
                }
                
                withAnimation(
                    .easeInOut(duration: 0.8)
                    .repeatForever(autoreverses: true)
                ) {
                    sparklePulse.toggle()
                }
            }
        }
        .frame(width: 160, height: 160)
        .background(Color.clear)
    }
}

private extension LoadingView {
    func backgroundCircles(size: CGFloat, center: CGPoint) -> some View {
        ZStack {
            Circle()
                .fill(theme.primary)
                .frame(width: size * 0.48)
                .scaleEffect(pulseScale)
                .opacity(pulseOpacity)
                .position(x: center.x + size * -0.22, y: center.y + size * 0.08)
            
            Circle()
                .fill(theme.tint)
                .frame(width: size * 0.32)
                .scaleEffect(pulseScale)
                .opacity(pulseOpacity)
                .position(x: center.x + size * 0.28, y: center.y + size * 0.25)
        }
    }
    
    func musicNotes(size: CGFloat, center: CGPoint) -> some View {
        ZStack {
            Iconoir.musicDoubleNote.asImage
                .resizable()
                .scaledToFit()
                .frame(width: size * 0.32)
                .rotationEffect(.degrees(-10))
                .position(x: center.x + size * -0.06, y: center.y + size * -0.07)
                .foregroundStyle(theme.primary.opacity(0.8))
            
            Iconoir.musicDoubleNote.asImage
                .resizable()
                .scaledToFit()
                .frame(width: size * 0.26)
                .rotationEffect(.degrees(10))
                .position(x: center.x + size * 0.18, y: center.y + size * 0.12)
                .foregroundStyle(theme.tint.opacity(0.8))
        }
    }
    
    func sparkles(size: CGFloat, center: CGPoint) -> some View {
        ZStack {
            sparkle(at: CGPoint(x: center.x + size * -0.06, y: center.y + size * 0.25), rotateClockwise: true)
            sparkle(at: CGPoint(x: center.x + size * 0.28, y: center.y + size * -0.25))
        }
    }
    
    func sparkle(at point: CGPoint, rotateClockwise: Bool = false) -> some View {
        let rotationAngle: Double = rotateClockwise
            ? (sparklePulse ? 5 : -5)
            : (sparklePulse ? -5 : 5)
        return Iconoir.sparks.asImage
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
            .scaleEffect(sparklePulse ? 1.1 : 0.7)
            .opacity(sparklePulse ? 1 : 0.3)
            .rotationEffect(.degrees(rotationAngle))
            .position(point)
            .foregroundStyle(theme.secondary)
    }
}

