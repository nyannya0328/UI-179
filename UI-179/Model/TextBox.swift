//
//  TextBox.swift
//  UI-179
//
//  Created by にゃんにゃん丸 on 2021/05/09.
//

import SwiftUI

struct TextBox: Identifiable {
    var id = UUID().uuidString
    var text : String = ""
    var offset : CGSize = .zero
    var isBold :Bool = false
    var lastOffset : CGSize = .zero
    var textColor : Color = .white
    var size : CGFloat = 30
    var isAdded : Bool = false
    
}

