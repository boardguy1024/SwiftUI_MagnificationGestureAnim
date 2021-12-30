//
//  Event.swift
//  SwiftUI_MagnificationGestureAnim
//
//  Created by park kyung seok on 2021/12/29.
//

import SwiftUI

let colors: [Color] = [.red, .orange, .blue, .green, .pink]

struct Event: Identifiable {
    var id = UUID().uuidString
    var date: String
    var title: String
    var timing: String
    var color = colors.randomElement() ?? .red
}

var events: [Event] = [
    Event(date: "Jul 18", title: "GYM", timing: "1:20 - 3:30"),
    Event(date: "Jul 19", title: "Study", timing: "12:20 - 4:30"),
    Event(date: "Jul 20", title: "Surfing", timing: "13:20 - 15:30"),
    Event(date: "Jul 21", title: "Programing", timing: "1:20 - 3:30"),
    Event(date: "Jul 22", title: "Gaming", timing: "1:50 - 3:50"),
    Event(date: "Jul 23", title: "Cycling", timing: "12:20 - 3:30")
]
