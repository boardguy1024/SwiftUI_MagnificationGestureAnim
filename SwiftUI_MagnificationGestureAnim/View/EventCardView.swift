//
//  EventCardView.swift
//  SwiftUI_MagnificationGestureAnim
//
//  Created by park kyung seok on 2021/12/29.
//

import SwiftUI

struct EventCardView: View {
    var event: Event
    
    @Binding var pinchValue: CGFloat
    
    var body: some View {
        
        HStack(spacing: 20) {
            Text(getDate())
                .font(.title2.bold())
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()
            
            HStack(spacing: 15) {
                
                Capsule()
                    .fill(event.color)
                    .frame(width: 2)
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text(event.title)
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text(event.timing)
                            .foregroundColor(.secondary)
                    }
                    .frame(height: 70)
                    
                    // この Vstackのheightをupdateする理由は
                    // heightを可変しても上段のタイトルVstackのポジションはそのままにするため（Spacerの役割）
                    VStack(alignment: .leading, spacing: 10) {
                        
                        
                        // もちろん、この中のタスクの高さによる maxHeightに変更することも可能！！
                        // 固定 maxHeightだけと、実際のアプリではこのタスクによる高さでアコディオンするのも良いかも
                        Text(".Meet iJustine")
                            .lineLimit(1)
                        
                        Text(".Meet iJustine")
                            .lineLimit(1)
                        
                        Text(".Meet iJustine")
                            .lineLimit(1)
                        
                        HStack(spacing: 10) {
                            
                            ForEach(1...3, id: \.self) { index in
                                Image("p\(index)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 35, height: 35)
                                    .clipShape(Circle())
                                    .offset(x: -getImageOffsetX())
                            }
                        }
                        .padding(.leading, 20)
                        
                    }
                    .padding(.top)
                    .frame(height: getMaxCardSize(), alignment: .top)
                    .opacity(getOpacity())


                }
            

                Spacer(minLength: 0)

            }
            .padding()
            // setting height as 100
            // max height will be 280
            // remaing 180 will be calculated from pinch value
            .frame(height: 100 + getMaxCardSize())
            .clipped()
            .background(.white, in: RoundedRectangle(cornerRadius: 15))
            .shadow(color: .black.opacity(0.05), radius: 5, x: 5, y: 5)
        }
      
    }
    
    func getDate() -> String {
        return event.date.replacingOccurrences(of: " ", with: "\n")
    }
    
    // getting card size
    func getMaxCardSize() -> CGFloat {
        
        let pinchedHeight = pinchValue * 40
        return pinchedHeight
    }
    
    func getOpacity() -> CGFloat {
        // pinchValue max値が 4.5なので 4.5 / 4.5 = 1になるように計算
        //let progress = pinchValue / 4.5
        
        // もしくは
        // pinchValue * 40 の maxValue = 180なので 180に割ると 1か０になる
        let progress = getMaxCardSize() / 180
        return progress
    }
    
    func getImageOffsetX() -> CGFloat {
        // 1 * 20 or 0 * 20
        return getOpacity() * 20
    }
}

struct EventCardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
