//
//  Home.swift
//  SwiftUI_MagnificationGestureAnim
//
//  Created by park kyung seok on 2021/12/29.
//

import SwiftUI

struct Home: View {
    
    // Gesture Properties
    @GestureState var pinchStarted: Bool = false
    @State var pinchValue: CGFloat = 0
    @State var lastPinch: CGFloat = 0
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 18) {
                
                ForEach(events) { event in
                    
                    // Event Card View
                    EventCardView(event: event, pinchValue: $pinchValue)
                }
            }
            .padding([.vertical, .leading ])
        }
        // Adding Magnificaion Gesture
        .gesture(
            MagnificationGesture()
                .updating($pinchStarted, body: { value, out, _ in
                    // value: Gesture中の値
                    // out: $pinchStarted bindingされている参照
                    out = true
                    
                    print(out)
                })
                .onChanged({ value in
                    
                    // value: updatingの直後のvalue
           
                    if pinchStarted {
                        // pinch開始直後の次からの。。。
                        
                        let delta = lastPinch + ((value - 1) > 0 ? (value - 1) : (value - 1) * 4.5 )
                        
                        // 絶対数
                        var absoluteDelta = delta > 0 ? delta : 0
                        absoluteDelta = absoluteDelta < 4.5 ? absoluteDelta : 4.5
                        self.pinchValue = absoluteDelta
                    }
                })
                .onEnded({ value in
                    
                    withAnimation(.easeOut) {
                        
                        // 2を境目に Gestureをやめたタイミングで heightをMax / Minにアニメーションする
                        if pinchValue > 2 {
                            
                            pinchValue = 4.5
                            lastPinch = 4.5
                        } else {
                            pinchValue = 0
                            lastPinch = 0
                        }
                    }
                })
        )
        
        .safeAreaInset(edge: .top) {
            
            HStack {
                Text("Event's")
                    .font(.largeTitle.bold())
                    .foregroundColor(.primary)
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "magnifyingglass")
                        .font(.title)
                        .foregroundColor(.primary)
                }
            }
            .padding()
            .background(.ultraThinMaterial)
        }
        .background(Color.primary.opacity(0.05))
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
